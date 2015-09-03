class PrompaXeroConnection < ActiveRecord::Base
  require 'prompa_api'

  belongs_to :prompa_organisation
  belongs_to :xero_organisation
  has_many :employees


  validates_presence_of :prompa_organisation_id, :xero_organisation_id
  validates_uniqueness_of :prompa_organisation_id, scope: :xero_organisation_id


  # call : PrompaXeroConnection.sync(fetch_new_xero_employees)

  def self.sync(method_name)

    @setting = Setting.first

    @@prompa_conn = PrompaApi.new(
        @setting.prompa_url
    )

    @@xero_conn = Xeroizer::PublicApplication.new(
        @setting.consumer_key,
        @setting.consumer_secret,
    )

    @@xero_conn.payroll.Employee.all

    PrompaXeroConnection.joins(:prompa_organisation).where({
      expired: false,
      prompa_organisations: {expired: false}
    }).find_in_batches do |connections|
      connections.each do |connection|
        begin
          connection.public_send(method_name)
        rescue Xeroizer::OAuth::TokenExpired
          connection.expired = true
          connection.save
          logger.info("Invalid Xero token")
        rescue InvalidPrompaTokenException
          connection.prompa_organisation.expired = true
          connection.save
          logger.info("Invalid Prompa token")
        end
      end
    end
  end


  def fetch_new_xero_employees
    @@xero_conn.authorize_from_access(xero_token, xero_key)

    @xero_employees = @@xero_conn.payroll.Employee.all
    @xero_employees.each { |xero_employee| insert_to_db xero_employee }
  end

  def insert_to_db xero_employee

    return if already_inserted? xero_employee

    @employee =  Employee.find_or_initialize_by({
        name: xero_employee.name,
        date_of_birth: Date.parse(xero_employee.date_of_birth),
        prompa_xero_connection_id: self.id,
    })

    @employee.xero_id = xero_employee.id

    insert_new_xero_employee xero_employee unless @employee.prompa_id

    @employee.save!
  end

  def insert_new_xero_employee(xero_employee)
    @employee.name = xero_employee.name
    @employee.first_name = xero_employee.first_name
    @employee.last_name = xero_employee.last_name
    @employee.xero_id = xero_employee.id
    @employee.gender = xero_employee.gender
    @employee.email = xero_employee.email
    @employee.phone_number = xero_employee.phone_number
    @employee.mobile_phone = xero_employee.mobile_phone
    @employee.address = xero_employee.home_address.address_line1
    @employee.address_line_2 = xero_employee.home_address.address_line2
    @employee.state = xero_employee.home_address.region
    @employee.postcode = xero_employee.home_address.postal_code
  end

  def already_inserted? user
    Employee.where({
        xero_id: user.id,
        prompa_xero_connection_id: self.id
    }).present?
  end

  def update_contacts
    @@prompa_conn.authorize(prompa_organisation.token)
    @@xero_conn.authorize_from_access(xero_token, xero_key)

    @prompa_users = @@prompa_conn.get_staff_members(organisation_id)
    @xero_users = @@xero_conn.Contact.all

    @@xero_conn.Contact.batch_save do
      update_xero_users
    end
  end


  def get_xero_user(name)
    @xero_users.each { |x_user|
      return x_user if x_user.name == name
    }

    return @@xero_conn.Contact.new
  end

  def update_xero_users
      @prompa_users.each do |prompa_user|
        profile = prompa_user['user']['profile']

        xero_user = get_xero_user(profile['name'])

        xero_user.name = profile['name']
        xero_user.first_name = profile['first_name']
        xero_user.last_name = profile['last_name']
        xero_user.email_address = profile['email']
        xero_user.phones = update_phone_numbers(xero_user.phones, profile)

        # date_of_birth: profile['date_of_birth'],
        # gender: profile['gender'],
        puts "updating user #{ profile['name'] }"
      end
  end

end

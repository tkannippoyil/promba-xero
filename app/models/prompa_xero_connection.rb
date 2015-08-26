class PrompaXeroConnection < ActiveRecord::Base
  require 'prompa_api'

  belongs_to :prompa_organisation
  belongs_to :xero_organisation

  def self.sync

    @setting = Setting.first

    @@prompa_conn = PrompaApi.new(
        @setting.prompa_url
    )

    @@xero_conn = Xeroizer::PublicApplication.new(
        @setting.consumer_key,
        @setting.consumer_secret,
    )

    PrompaXeroConnection.all.each do |connection|
      begin
        connection.update_contacts
      rescue Xeroizer::OAuth::TokenExpired
        logger.info("Invalid xero token")
      end
    end
  end


  def update_contacts
    @@prompa_conn.authorize(prompa_organisation.token)
    @@xero_conn.authorize_from_access(xero_token, xero_key)

    @prompa_users = @@prompa_conn.get_users
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
        profile = prompa_user['profile']

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

  def update_phone_numbers(xero_phones, prompa_phones)
    xero_phones.each do |phone|
      phone.number = case phone.type
                       when 'DEFAULT'
                         prompa_phones['phone_number']
                       when 'DDI'
                         prompa_phones['home_phone']
                       when 'MOBILE'
                         prompa_phones['mobile_phone']
                       when 'FAX'
                         prompa_phones['mobile_phone']
                       else
                         0
                     end
      phone.area_code = 0
      phone.country_code = 0
    end
    return xero_phones
  end

end

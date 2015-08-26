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
      connection.update_contacts
    end
  end


  def update_contacts
    @@prompa_conn.authorize(prompa_organisation.token)

    @@xero_conn.authorize_from_access(
        xero_token,
        xero_key
    )

    @prompa_users = @@prompa_conn.get_users
    @xero_users = @@xero_conn.Contact.all

    @prompa_users.each do |prompa_user|
      profile = prompa_user['profile']

      user_exits = @@xero_conn.Contact.all(
          where: {name: profile['name']}
      ).first

      xero_user = user_exits || @@xero_conn.Contact.new

      xero_user.name = profile['name']
      xero_user.first_name = profile['first_name']
      xero_user.last_name = profile['last_name']
      xero_user.email_address = profile['email']

      xero_user.phones.each { |phone|
        phone.number = case phone.type
                          when 'DEFAULT'
                            profile['phone_number']
                          when 'DDI'
                            profile['home_phone']
                          when 'MOBILE'
                            profile['mobile_phone']
                          when 'FAX'
                            profile['mobile_phone']
                          else
                            0
                       end
        phone.area_code = 0
        phone.country_code = 0
      }
      # date_of_birth: profile['date_of_birth'],
      # gender: profile['gender'],

      xero_user.save

    end
  end
end

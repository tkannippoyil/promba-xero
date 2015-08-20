class Setting < ActiveRecord::Base
  validates_presence_of :consumer_key, :consumer_secret,
                        :prompa_url, :prompa_token, :api_token
end

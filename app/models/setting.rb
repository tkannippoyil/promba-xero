class Setting < ActiveRecord::Base
  validates_presence_of :consumer_key, :consumer_secret,
                        :prompa_url, :api_token
end

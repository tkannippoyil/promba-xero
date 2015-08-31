require 'prompa_api'
class PrompaOrganisation < ActiveRecord::Base
  has_one :prompa_xero_connection

  validates_presence_of :organisation_id, :token
  validate :valid_token?


  def valid_token?
    @setting = Setting.first
    @prompa_api = PrompaApi.new(@setting.prompa_url)
    begin
      @prompa_api.authorize(token)
    rescue
      errors.add(:token, "is invalid")
    end
  end

  def as_json(options = {})
    if errors.present?
      { errors: errors }
    else
      super
    end
  end

end

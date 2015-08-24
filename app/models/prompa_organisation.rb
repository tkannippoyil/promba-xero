class PrompaOrganisation < ActiveRecord::Base
  has_one :prompa_xero_connection

  validates_presence_of :organisation_id, :owner_id

  def as_json(options = {})
    if errors.present?
      { errors: errors }
    else
      super
    end
  end

end

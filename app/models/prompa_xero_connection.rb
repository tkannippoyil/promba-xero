class PrompaXeroConnection < ActiveRecord::Base
  belongs_to :prompa_organisation, foreign_key: :prompa_organisation_id
  belongs_to :xero_organisation, foreign_key: :prompa_organisation_id
end

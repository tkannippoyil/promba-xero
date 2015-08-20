class PrompaXeroConnection < ActiveRecord::Base
  belongs_to :prompa_organisation
  belongs_to :xero_organisation
end

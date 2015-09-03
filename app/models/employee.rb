class Employee < ActiveRecord::Base
  belongs_to :prompa_xero_connection

  validates_uniqueness_of :prompa_id, scope: :xero_id
  validates_presence_of :prompa_xero_connection_id

end

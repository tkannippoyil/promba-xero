class AddXeroIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :xero_id, :string
  end
end

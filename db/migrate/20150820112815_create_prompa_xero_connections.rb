class CreatePrompaXeroConnections < ActiveRecord::Migration
  def change
    create_table :prompa_xero_connections do |t|
      t.integer :prompa_organisation_id
      t.integer :xero_organisation_id
      t.string :xero_token
      t.string :xero_key
      t.boolean :expired, default: false

      t.timestamps null: false
    end
  end
end

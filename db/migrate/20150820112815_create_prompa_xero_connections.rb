class CreatePrompaXeroConnections < ActiveRecord::Migration
  def change
    create_table :prompa_xero_connections do |t|
      t.string :prompa_organisation_id
      t.string :xero_organisation_id
      t.string :xero_token
      t.boolean :valid

      t.timestamps null: false
    end
  end
end

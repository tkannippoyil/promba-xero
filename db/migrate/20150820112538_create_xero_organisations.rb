class CreateXeroOrganisations < ActiveRecord::Migration
  def change
    create_table :xero_organisations do |t|
      t.string :owner_id
      t.string :organisation_id

      t.timestamps null: false
    end
  end
end

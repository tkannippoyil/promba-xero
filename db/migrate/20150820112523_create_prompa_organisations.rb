class CreatePrompaOrganisations < ActiveRecord::Migration
  def change
    create_table :prompa_organisations do |t|
      t.string :owner_id
      t.string :token
      t.string :organisation_id

      t.timestamps null: false
    end
  end
end

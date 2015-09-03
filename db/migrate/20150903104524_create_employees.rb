class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :prompa_id
      t.string :xero_id
      t.string :gender
      t.string :email
      t.string :phone_number
      t.string :mobile_phone
      t.string :address
      t.string :address_line_2
      t.string :suburb
      t.string :state
      t.integer :postcode
      t.integer :prompa_xero_connection_id

      t.timestamps null: false
    end
  end
end

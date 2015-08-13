class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.text :home_address
      t.string :email
      t.string :mobile_number
      t.string :employment_basis
      t.string :classification
      t.string :gender
      t.float :pay_adjustment
      t.integer :xeroemployeeid
      t.string :preferred_name
      t.boolean :is_supervisor

      t.timestamps null: false
    end
  end
end

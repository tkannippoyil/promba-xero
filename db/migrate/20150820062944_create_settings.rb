class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :consumer_key
      t.string :consumer_secret
      t.string :prompa_url
      t.string :api_token

      t.timestamps null: false
    end
  end
end

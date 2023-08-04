class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :password_digest
      t.string :forename
      t.string :surname
      t.references :title, type: :uuid, foreign_key: true
      t.text :address
      t.string :insurer
      t.string :telephone_number
      t.string :vehicle_registration
      t.string :access_token
      t.string :promo_code
      t.boolean :is_admin, default: false
      
      t.references :company, type: :uuid, foreign_key: true

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end

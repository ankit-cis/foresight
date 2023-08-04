class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies, id: :uuid do |t|
      t.string :name
      t.string :subdomain
      t.references :company_type, type: :uuid, foreign_key: true

      t.string :email
      t.string :forename
      t.string :surname
      t.references :title, type: :uuid, foreign_key: true

      t.string :address_1
      t.string :address_2
      t.string :town
      t.string :county
      t.string :postcode
      t.string :telephone_number
      t.references :payment_type, type: :uuid, foreign_key: true
      t.integer :app_licenses

      t.timestamps
    end
  end
end

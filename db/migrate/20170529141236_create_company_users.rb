class CreateCompanyUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :company_users, id: :uuid do |t|
      t.references :company, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.boolean :is_company_admin, default: false
      t.boolean :is_app_user, default: false
      t.string :license_code

      t.timestamps
    end
  end
end

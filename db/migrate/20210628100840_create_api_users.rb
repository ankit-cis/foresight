class CreateApiUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :api_users, id: :uuid do |t|
      t.string :name
      t.references :company, type: :uuid, foreign_key: true
      t.string :access_token

      t.timestamps
    end
  end
end

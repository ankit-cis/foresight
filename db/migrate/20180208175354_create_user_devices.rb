class CreateUserDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :user_devices, id: :uuid  do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.string :endpoint_arn
      t.string :token
      t.string :app_version
      t.string :system_name
      t.string :system_version
      t.string :device_model

      t.timestamps
    end
  end
end

class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings, id: :uuid do |t|
      t.references :company, type: :uuid, foreign_key: true
      t.string :notification_email

      t.timestamps
    end
  end
end

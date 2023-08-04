class CreateUserEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :user_events, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :user_device, type: :uuid, foreign_key: true
      t.string :event_type_const
      t.text :description

      t.timestamps
    end
  end
end

class CreateEventTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :event_types, id: :uuid do |t|
      t.string :name
      t.string :event_type_const
      t.text :description

      t.timestamps
    end
  end
end

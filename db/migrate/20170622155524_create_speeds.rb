class CreateSpeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :speeds, id: :uuid do |t|
      t.references :video, type: :uuid, foreign_key: true
      t.string :speed
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end

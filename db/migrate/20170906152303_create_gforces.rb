class CreateGforces < ActiveRecord::Migration[5.1]
  def change
    create_table :gforces, id: :uuid do |t|
      t.references :video, type: :uuid, foreign_key: true
      t.float :forward_force
      t.float :side_force
      t.float :vertical_force
      t.datetime :detected_time

      t.timestamps
    end
  end
end

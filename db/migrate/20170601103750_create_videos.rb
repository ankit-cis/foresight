class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :company, type: :uuid, foreign_key: true
      t.float :lat
      t.float :long
      t.string :incident_video

      t.timestamps
    end
  end
end

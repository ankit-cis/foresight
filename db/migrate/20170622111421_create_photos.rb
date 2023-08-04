class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos, id: :uuid do |t|
      t.references :accident, type: :uuid, foreign_key: true
      t.string :accident_image

      t.timestamps
    end
  end
end

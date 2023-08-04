class CreateAccidents < ActiveRecord::Migration[5.1]
  def change
    create_table :accidents, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :company, type: :uuid, foreign_key: true
      t.float :lat
      t.float :long
      t.references :video, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end

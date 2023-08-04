class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.references :company, type: :uuid, foreign_key: true
      t.string :title
      t.string :body
      t.text :content
      t.date :expires

      t.timestamps
    end
  end
end

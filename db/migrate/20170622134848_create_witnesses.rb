class CreateWitnesses < ActiveRecord::Migration[5.1]
  def change
    create_table :witnesses, id: :uuid do |t|
      t.references :accident, type: :uuid, foreign_key: true
      t.string :name
      t.string :telephone_number
      t.string :address
      t.string :postcode

      t.timestamps
    end
  end
end

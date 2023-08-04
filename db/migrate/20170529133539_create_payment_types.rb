class CreatePaymentTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_types, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :payment_type_const

      t.timestamps
    end
  end
end

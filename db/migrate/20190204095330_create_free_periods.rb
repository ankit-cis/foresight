class CreateFreePeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :free_periods do |t|
      t.string :name
      t.string :amount
      t.references :period, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end

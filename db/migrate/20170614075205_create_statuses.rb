class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :status_constant
      t.integer :sort_order

      t.timestamps
    end
  end
end

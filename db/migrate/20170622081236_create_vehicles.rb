class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles, id: :uuid do |t|
      t.references :accident, type: :uuid, foreign_key: true
      t.string :registration_number
      t.string :driver_name
      t.string :insurance_company
      t.string :insurance_policy_number

      t.timestamps
    end
  end
end

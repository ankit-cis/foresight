class CreateLicensePeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :license_periods, id: :uuid  do |t|
      t.string :name
      t.string :days

      t.timestamps
    end
  end
end

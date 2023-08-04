class AddRegistrationNumberToAccidents < ActiveRecord::Migration[5.1]
  def change
    add_column :accidents, :registration_number, :string
  end
end

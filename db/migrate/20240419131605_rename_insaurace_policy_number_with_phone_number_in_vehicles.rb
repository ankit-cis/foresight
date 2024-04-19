class RenameInsauracePolicyNumberWithPhoneNumberInVehicles < ActiveRecord::Migration[5.1]
  def change
    rename_column :vehicles, :insurance_policy_number, :phone_number
  end
end

class AddDatesToCompanyUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :company_users, :start_date, :date
    add_column :company_users, :end_date, :date
    add_reference :company_users, :license_period, type: :uuid, foreign_key: true
  end
end

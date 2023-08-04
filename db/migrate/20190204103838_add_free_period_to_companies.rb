class AddFreePeriodToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_reference :companies, :free_period, foreign_key: true
  end
end

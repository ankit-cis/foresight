class AddNotificationEmailToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :notification_email, :string
  end
end

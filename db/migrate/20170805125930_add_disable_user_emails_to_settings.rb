class AddDisableUserEmailsToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :disable_user_emails, :boolean, default: false
  end
end

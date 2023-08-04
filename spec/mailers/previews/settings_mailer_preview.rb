# Preview all emails at http://localhost:3000/rails/mailers/settings_mailer
class SettingsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/settings_mailer/upgrade_reset
  def upgrade_reset
    SettingsMailerMailer.upgrade_reset
  end

end

class SettingsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.settings_mailer.upgrade_reset.subject
  #
  def upgrade_reset(user_id)
    @user = User.unscoped.find(user_id)
    mail(to: @user.email, subject: '4Sight: Important Information Regarding 4Sight')
  end
end

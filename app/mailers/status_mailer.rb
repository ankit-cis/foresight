class StatusMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.status_mailer.false_alarm.subject
  #
  def false_alarm(user_id)
    @user = User.unscoped.find(user_id)
    mail(to: @user.email, subject: '4Sight Alert response: FALSE ALARM')
  end
end

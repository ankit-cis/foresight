class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def signup_confirmation(user_id, password)
    @user = User.unscoped.find(user_id)
    @password = password
    mail(to: @user.email, subject: 'Your 4Sight account')
  end
  
  def password_reset(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: '4Sight Password Reset')
  end
end

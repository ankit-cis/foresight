# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/signup_confirmation
  def signup_confirmation
    @user = User.first
    UserMailer.signup_confirmation(@user.id, "banana")
  end

  def password_reset
    @user = User.first
    UserMailer.password_reset(@user.id)
  end
end

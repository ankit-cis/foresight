class AccidentMailer < ApplicationMailer
  
  def new_accident_uploaded(accident_id)
    @accident = Accident.unscoped.find(accident_id)

    settings = @accident.company.setting
    mail(to: [settings.notification_email, @accident.company.notification_email], subject: '4Sight: Accident details received.')
  end

  def user_confirmation_new_accident(user_id)
    @user = User.find_by(id: user_id)
    mail(to: @user.email, subject: '4Sight: Accident details received.')
  end
end

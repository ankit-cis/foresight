class AccidentMailer < ApplicationMailer
  
  def new_accident_uploaded(accident_id)
    @accident = Accident.unscoped.find(accident_id)

    settings = Setting.first
    mail(to: [settings.notification_email, @accident.company.notification_email], subject: '4Sight: Accident details received.')
  end
end

class ExceptionNotifierMailer < ApplicationMailer
  default from: 'noreply@get4sight.co.uk'

  def notify_exception(exception)
    @exception = exception
    mail(to: 'nettestuser12@mailinator.com', subject: 'Exception Notification')
  end
end

class ExceptionNotifierMailer < ApplicationMailer
  default from: 'noreply@get4sight.co.uk'

  def notify_exception(exception)
    @exception = exception
    mail(to: 'paul@digitalflair.co.uk', subject: 'Exception Notification')
  end
end

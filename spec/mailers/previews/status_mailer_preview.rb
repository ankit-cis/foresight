# Preview all emails at http://localhost:3000/rails/mailers/status_mailer
class StatusMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/status_mailer/false_alarm
  def false_alarm
    StatusMailerMailer.false_alarm
  end

end

# Preview all emails at http://localhost:3000/rails/mailers/accident_mailer
class AccidentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/accident_mailer/new_accident_uploaded
  def new_accident_uploaded
    AccidentMailerMailer.new_accident_uploaded
  end

end

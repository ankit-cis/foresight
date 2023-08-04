# Preview all emails at http://localhost:3000/rails/mailers/video_mailer
class VideoMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/video_mailer/new_video_uploaded
  def new_video_uploaded
    VideoMailerMailer.new_video_uploaded
  end

end

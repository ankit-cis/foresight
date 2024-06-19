class VideoMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.video_mailer.new_video_uploaded.subject
  #
  def new_video_uploaded(video_id)
    @video = Video.unscoped.find(video_id)

    settings = @video.company.setting
    mail(to: [settings.notification_email, @video.company.notification_email], subject: '4Sight: A new video has been reported.')
  end
end

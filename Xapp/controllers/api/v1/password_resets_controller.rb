module Api
  module V1
    class PasswordResetsController < ApiApplicationController
      def create
        user = User.find_by_email(params[:email])
        user.set_password_reset_token if user
        UserMailer.password_reset(user.id).deliver_later if user

        render :json => { :notice => "Email sent with password reset instructions." }, status: :created
      end
    end
  end
end
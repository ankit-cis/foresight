module Api
  module V1
    class SessionsController < ApiApplicationController

      def create
        @user = User.unscoped.find_by_email(params[:email].downcase.delete(' '))
        if @user && @user.authenticate(params[:password])

          render :create, status: :ok
        else
          render json: '{"errors":["Invalid email or password"]}', status: 401
        end
      end

      def destroy
        session[:user_id] = nil
        redirect_to root_url, notice: "Logged out!"
      end
    end
  end
end

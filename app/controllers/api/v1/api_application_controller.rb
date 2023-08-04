module Api
  module V1
    class ApiApplicationController < ActionController::API
      include ActionController::HttpAuthentication::Token::ControllerMethods

      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: { error: e.message }, status: :not_found
      end

      rescue_from ActionController::ParameterMissing do |e|
        # You can even render a jbuilder template too!
        render json: {error: e.message }, status: :unprocessable_entity
      end
        
      private
      def current_user
        @current_user ||= authenticate_token
      end
      helper_method :current_user

      def current_user_device
        if request.headers["HTTP-X-WWW-user-device-id"]
          @current_user_device ||= current_user.user_devices.find(request.headers["HTTP-X-WWW-user-device-id"])
        end  
      end
      helper_method :current_user_device
      
      protected
      def authorize
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        authenticate_with_http_token do |token, options|
          User.unscoped.find_by(access_token: token)
        end
      end

      def render_unauthorized
        self.headers['WWW-Authenticate'] = 'Token realm="Application"'
        render json: {error: "Invalid credentials" }, status: 401
      end
    end
  end
end

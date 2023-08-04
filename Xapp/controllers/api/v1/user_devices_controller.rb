module Api
  module V1
    class UserDevicesController < ApiApplicationController
      before_action :set_user_device, only: [:show, :edit, :update, :destroy]
      before_action :authorize

      def index
        @user_devices = current_user.user_devices
      end

      def show
      end

      def new
        @user_device = current_user.user_devices.build
      end

      def edit
      end

      def create
        @user_device = current_user.user_devices.build(user_device_params)
        
        if @user_device.token && @user_device.token.length > 0
          sns = Aws::SNS::Client.new

          if @user_device.system_name == "iOS"
            if Rails.env.production?
              platform_application_arn = 'arn:aws:sns:eu-west-1:428765215768:app/APNS/4Sight'
            else
              platform_application_arn = 'arn:aws:sns:eu-west-1:428765215768:app/APNS_SANDBOX/4SightSandbox'
            end
          else
            platform_application_arn = 'arn:aws:sns:eu-west-1:428765215768:app/GCM/4SightAndroid'
          end
          
          endpoint = sns.create_platform_endpoint(
              platform_application_arn: platform_application_arn, 
              token: @user_device.token, 
              attributes: {}
          )

          @user_device.endpoint_arn = endpoint[:endpoint_arn]
        end
        
        if @user_device.save
          render :show, status: :created
        else
          render json: @user_device.errors, status: :unprocessable_entity
        end
      end

      def update
        
        token = @user_device.token
        
        if @user_device.update(user_device_params)
          
          if @user_device.token && @user_device.token.length > 0
            sns = Aws::SNS::Client.new

            if @user_device.system_name == "iOS"
              if Rails.env.production?
                platform_application_arn = 'arn:aws:sns:eu-west-1:428765215768:app/APNS/4Sight'
              else
                platform_application_arn = 'arn:aws:sns:eu-west-1:428765215768:app/APNS_SANDBOX/4SightSandbox'
              end
            else
              platform_application_arn = 'arn:aws:sns:eu-west-1:428765215768:app/GCM/4SightAndroid'
            end
          
            endpoint = sns.create_platform_endpoint(
                platform_application_arn: platform_application_arn, 
                token: @user_device.token, 
                attributes: {}
            )

            @user_device.endpoint_arn = endpoint[:endpoint_arn]
            @user_device.save!
          end
                     
          render :show, status: :ok
        else
          render json: @user_device.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user_device.token = nil
        @user_device.endpoint_arn = nil
        @user_device.save!
        
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user_device
          @user_device = current_user.user_devices.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def user_device_params
          params.require(:user_device).permit(:token, :app_version, :system_name, :system_version, :device_model)
        end
    end
  end
end

module Api
  module V1
    class UsersController < ApiApplicationController
      before_action :authorize, except: [:create]

      def create
        @user = User.new(new_user_params)
        @user.email = @user.email.downcase.delete(' ')
        
        # Add the default company to the user
        @user.company_id = Setting.first.company_id
        
        if @user.save
          
          # If we don't have a current user device then set one up
          if !@current_user_device
            @current_user_device = @user.user_devices.build
            @current_user_device.save!
          end
          
          default_company = Setting.first.company
          
          company_user = CompanyUser.new
          company_user.user_id = @user.id
          company_user.company_id = default_company.id
          company_user.is_app_user = true
          company_user.is_company_admin = false
                
          company_user.save!
          
          render :create, status: :created
        else
          render :json => { :errors => @user.errors.full_messages }, :status => 422
        end
      end

      def update
        @user = current_user
        if @user.update(user_params)
          @user.email = @user.email.downcase.delete(' ')
          @user.save
          render :show, status: :ok
        else
          render :json => { :errors => @user.errors.full_messages }, :status => 422
        end
      end
      
      def show
        @user = current_user
        if @user
          render :show, status: :ok
        else
          render :json => { :errors => @user.errors.full_messages }, :status => 422
        end
      end
      
      def password
        @user = current_user

        if @user && @user.authenticate(params[:current_password])
          @user.password = params[:new_password]
          @user.password_confirmation = params[:new_password_confirmation]
          
          if @user.save
            render :show, status: :accepted
          else
            render :json => { :errors => @user.errors.full_messages }, :status => 422
          end
        else
          render json: '{"errors":["Invalid email or password"]}', status: 401
        end
      end
      
      private

        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
          params.require(:user).permit(:email, :name, :date_of_birth, :forename, :surname, :address, :insurer, :telephone_number, :vehicle_registration, :terms_accepted)
        end
        
        def new_user_params
          params.permit(:email, :surname, :forename, :address, :promo_code, :telephone_number, :insurer, :vehicle_registration, :password, :password_confirmation, :terms_accepted)
        end
    end
  end
end
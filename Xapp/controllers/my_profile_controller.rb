class MyProfileController < ApplicationController
  before_action :authorize
  before_action :set_user, only: [:show, :edit, :update, :change_password, :update_password]

  # GET /my_profiles/1
  # GET /my_profiles/1.json
  def show
  end

  # GET /my_profiles/1/edit
  def edit
  end


  # PATCH/PUT /my_profiles/1
  # PATCH/PUT /my_profiles/1.json
  def update
    if @user.update(user_params)
      redirect_to my_profile_path(@user), notice: 'My profile was successfully updated.'
    else
      render :edit
    end
  end

  def change_password
  end
  
  def update_password

    if @user && @user.authenticate(params[:user][:current_password])
      @user.password = params[:user][:new_password]
      @user.password_confirmation = params[:user][:new_password_confirmation]
      
      if @user.save
        render :show
      else
        render :change_password
      end
    else
      flash.now[:alert] = "Invalid email or password" 
      
      render :change_password
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password_digest, :forename, :surname, :title_id, :address, :vehicle_registration, :insurer, :telephone_number, :create_license, :make_company_admin)
    end
end

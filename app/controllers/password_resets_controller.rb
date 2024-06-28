class PasswordResetsController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:update]

  def create
    user = User.find_by_email(params[:email])
    if user.present?
      user.set_password_reset_token if user
      UserMailer.password_reset(user.id).deliver_now if user
      @email = params[:email]
      if user.is_admin? || user.is_company_admin?(user.company)
        redirect_to login_url, :notice => "Mail has been send to reset your password"
      else
        render :password_sent
      end
    else
      redirect_to new_password_reset_path, :notice => "Something went wrong. Please check that the user account exists"
    end
  end

  def edit
    @user = User.unscoped.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.unscoped.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(user_params)
      if current_user.present?
        session.destroy
      end
      if @user.is_admin? || @user.is_company_admin?(@user.company)
        redirect_to login_url, :notice => "Mail has been send to reset your password"
      else
        render :password_sent
      end
    else
      render :edit
    end
  end
  
  def password_sent
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  
end
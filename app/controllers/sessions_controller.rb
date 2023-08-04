class SessionsController < ApplicationController
  #skip_before_action :verify_authenticity_token, only: [:create]

  def new
  end

  def create
    user = User.unscoped.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      if session[:redirect_back_to]
        redirect = session[:redirect_back_to]
        session[:redirect_back_to] = nil
        redirect_to redirect
      else      
        redirect_to root_url
      end
      
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:redirect_back_to] = nil
    redirect_to login_url, notice: "Logged out!"
  end
end

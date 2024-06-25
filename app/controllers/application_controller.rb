class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  around_action :scope_current_company

  # before_action :ensure_subdomain
  rescue_from Exception, with: :render_500
  private

  def render_500(exception = nil)
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}"
    end
    respond_to do |format|
      format.html { render file: Rails.root.join('public', '500.html'), status: :internal_server_error, layout: false }
      format.all { head :internal_server_error }
    end
  end

  def ensure_subdomain
    if current_user
      if request.subdomain != current_user.company.subdomain
        redirect_to subdomain: current_user.company.subdomain, :controller => controller_name, :action => action_name
      end
    end
  end

  def current_user
    @current_user ||= User.unscoped.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    if current_user.nil?
      session[:redirect_back_to] = request.url
      redirect_to login_url, alert: "Not authorized"

    else
      session[:redirect_back_to] = nil
    end
  end
  
  def admin_required    
    if current_user && current_user.is_admin
      true
    else
      redirect_to root_url, alert: "Not authorized"
      false
    end
  end

  def is_company_admin?
    if current_user && current_user.is_admin
      true
    elsif current_user && current_company && current_user.is_company_admin?(current_company)
      true
    else
      false
    end
  end
  helper_method :is_company_admin?
  
  def company_admin_required
    if current_user && current_user.is_admin
      true
    elsif current_user && current_company && current_user.is_company_admin?(current_company)
      true
    else
      redirect_to root_url, alert: "Not authorized"
      false
    end
  end
  
  
  def current_company    
    current_user.company
  end
  helper_method :current_company

  def scope_current_company
    Company.current_id = current_company.id if should_get_company?
    if current_user
      Company.is_admin = current_user.is_admin
    else
      Company.is_admin = false
    end
    yield
  ensure
    Company.current_id = nil
    Company.is_admin = false
  end
  
  def should_get_company?
    !request.subdomain.blank? && current_user && !current_user.is_admin
  end
end

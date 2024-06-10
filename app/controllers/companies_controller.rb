class CompaniesController < ApplicationController
  before_action :authorize
  before_action :admin_required, only: [:index]
  before_action :company_admin_required

  before_action :set_company, only: [:show, :edit, :update, :destroy]

  
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.company_secure.all.order(:name).page params[:page]
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    if params[:id]
      @users = User.where(company_id: params[:id])
    else
      @users = User.company_secure.where(company_id: @company.id)
    end
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        user = User.find_by_email(@company.email)
        
        if user.nil?
          user = User.new
        end
        
        password = SecureRandom.urlsafe_base64(8)
        
        user.email = @company.email
        user.forename = @company.forename
        user.surname = @company.surname
        user.title_id = @company.title_id
        user.company_id = @company.id
        user.telephone_number = @company.telephone_number
        user.address = [@company.address_1, @company.address_2, @company.town, @company.county, @company.postcode].reject(&:blank?).join(', ')
        user.password = password
        user.password_confirmation = password
        user.save!
        
        company_user = CompanyUser.new
        company_user.user_id = user.id
        company_user.company_id = @company.id
        company_user.is_app_user = true
        company_user.is_company_admin = true
        company_user.license_code = SecureRandom.uuid
        company_user.save!
        
        settings = Setting.first
        if settings.disable_user_emails != true
          UserMailer.signup_confirmation(user.id, password).deliver_later
        end
        
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      if current_user.is_admin
        params.require(:company).permit(:name, :forename, :surname, :email, :company_type_id, :address_1, :address_2, :town, :county, :postcode, :telephone_number, :payment_type_id, :app_licenses, :notification_email, :free_period_id)
      else
        params.require(:company).permit(:name, :forename, :surname, :email, :company_type_id, :address_1, :address_2, :town, :county, :postcode, :telephone_number, :payment_type_id, :app_licenses, :notification_email, :free_period_id)
      end
    end
end

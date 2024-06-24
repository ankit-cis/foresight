require 'csv'    

class UsersController < ApplicationController
  before_action :authorize
  before_action :company_admin_required
  before_action :set_user, only: [:show, :edit, :update, :destroy, :revoke_license, :resend_welcome_email, :toggle_super_user]


  def index
    if params[:q]
      q_parames = params[:q]

      if q_parames[:has_iap]
        has_iap = q_parames[:has_iap]
      end

      if q_parames[:has_license]
        has_license= q_parames[:has_license]
      end

      if q_parames[:platform]
        platform = q_parames[:platform]
      end

    end

    if current_user.is_admin
      @initial_search = User.where.not(id: ["b57cb701-1a37-4ddc-89a8-8703b37f9b16", "812fd5f6-14a8-40d9-af03-48578850bda6"])
    else
      @initial_search = User.where.not(id: ["b57cb701-1a37-4ddc-89a8-8703b37f9b16", "812fd5f6-14a8-40d9-af03-48578850bda6"]).where(company_id: current_company.id)
    end

    if has_iap && (has_iap == 1 || has_iap == "1")
        @initial_search = @initial_search.has_iap
    end

    logger.info(has_license)
    if has_license && (has_license == 1 || has_license == "1")
        @initial_search = @initial_search.has_license
        logger.info("limiting to licensed")
    end

    if platform
      # iOS
      if platform == 1 || platform == "1"
        @initial_search = @initial_search.ios
      elsif platform == 0 || platform == "0"
        # Android
        @initial_search = @initial_search.android
        
      end
    end
    
    @search = @initial_search.ransack(params[:q])
    
      
    if params[:paged] == "false"
      @users = @search.result(distinct: true)
    else
      @users = @search.result(distinct: true).page params[:page]
    end
    if params[:q]
      @active_search = true
    else
      @active_search = false
    end
    
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end

  end

  def show
  end

  def new
    @user = User.new
    @user.company_users.build
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.email = @user.email.downcase
    
    unless current_user.is_admin?
      @user.company = current_company
    else
      @user.is_admin = false
    end

    unless @user.password.present?
      password = SecureRandom.urlsafe_base64(8)
      @user.password = password
    end
    @user.password_confirmation = @user.password

    respond_to do |format|
      if @user.save
        settings = @user.company.setting
        if settings.disable_user_emails != true
          UserMailer.signup_confirmation(@user.id, password).deliver_now
        end
        
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    redirect_path = params[:tab] == 'users' ?  company_url(id: @user.company.id, tab: 'users') : users_url
    updated_user_params = user_params[:password].present? ? user_params : user_params.except(:password)
    respond_to do |format|
      if @user.update(updated_user_params)
        format.html { redirect_to redirect_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    redirect_path = params[:tab] == 'users' ?  company_url(id: @user.company.id, tab: 'users') : users_url
    @user.destroy
    respond_to do |format|
      format.html { redirect_to redirect_path, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  def revoke_license
    company_user = @user.company_users.find_by_company_id(@user.company_id)
    company_user.license_code = nil
    company_user.save!
    redirect_to @user, notice: 'User was successfully updated.'
  end
  
  def import
    if current_user.is_admin
      company = Company.find(params[:company_id])
    else
      company = current_user.companies.find(params[:company_id])
    end

    if company.present?
      file = params[:file]
      if file.nil?
        redirect_to company_path(company), alert: 'File not supplied'
      else
        error_rows = []

        CSV.foreach(file.path, headers: true) do |row|
          existing_user = User.find_by(email: row["email"])
          if existing_user
            existing_user.update(company_id: company.id)
            
            company_user = CompanyUser.new(
              user_id: existing_user.id,
              company_id: existing_user.company_id,
              is_app_user: true,
              is_company_admin: false
            )
            error_rows << [
                row["email"],
                row["forename"],
                row["surname"],
                row["insurer"],
                row["vehicle_registration"],
                row["address"],
                row["telephone_number"],
                "User Updated"
              ]
            unless company_user.save
              if row["duration"].present?
                existing_user.company_users.each do |license|
                  license.update(
                    license_code: SecureRandom.uuid,
                    start_date: Date.today,
                    end_date: Date.today.next_year(row["duration"].to_i)
                  )
                end
              end
            end
          else
            user = User.new(
              email: row["email"],
              company_id: company.id,
              forename: row["forename"],
              surname: row["surname"],
              insurer: row["insurer"],
              vehicle_registration: row["vehicle_registration"],
              address: row["address"],
              telephone_number: row["telephone_number"],
              is_admin: false,
              password: SecureRandom.urlsafe_base64(8)
            )

            unless user.save
              error_rows << [
                row["email"],
                row["forename"],
                row["surname"],
                row["insurer"],
                row["vehicle_registration"],
                row["address"],
                row["telephone_number"],
                user.errors.full_messages.join(", ")
              ]
            end

            if user.save
              error_rows << [
                row["email"],
                row["forename"],
                row["surname"],
                row["insurer"],
                row["vehicle_registration"],
                row["address"],
                row["telephone_number"],
                "User Created"
              ]
            end

            if user.persisted?
              settings = user.company.setting
              UserMailer.signup_confirmation(user.id, user.password).deliver_now unless settings.disable_user_emails

              company_user = CompanyUser.new(
                user_id: user.id,
                company_id: user.company_id,
                is_app_user: true,
                is_company_admin: false,
                license_code: row["duration"].present? ? SecureRandom.uuid : nil,
                start_date: row["duration"].present? ? Date.today : nil,
                end_date: row["duration"].present? ? Date.today.next_year(row["duration"].to_i) : nil
              )

              company_user.save!
            end
          end
        end

        if error_rows.any?
          error_csv = generate_error_csv(error_rows)
          file_path = Rails.root.join('tmp', "import_errors_#{Time.now.to_i}.csv")
          File.write(file_path, error_csv)
          file_url = download_error_csv(file_path.basename.to_s)
          
          respond_to do |format|
            format.html { redirect_to company_path(id: company.id, tab: 'users', file_name: "import_errors_#{Time.now.to_i}.csv"), notice: 'Users imported' }
          end
        else
          redirect_to company_path(id: company.id, tab: 'users'), notice: 'Users imported'
        end
      end
    else
      redirect_to root_url, alert: 'Company not found'
    end
  end

  def download_error_csv(file_name)
    file_path = Rails.root.join('tmp', file_name)
    if File.exist?(file_path)
      send_file file_path, type: 'text/csv', filename: file_name, disposition: 'attachment'
    else
      redirect_to users_path, alert: "File not found."
    end
  end

  def resend_welcome_email
    password = SecureRandom.urlsafe_base64(8)
    @user.password = password
    @user.password_confirmation = password
    if @user.save
      UserMailer.signup_confirmation(@user.id, password).deliver_now
      redirect_to @user, notice: 'Welcome email resent.'
    else
      render :show
    end
  end
  
  def toggle_super_user
    if current_user.is_admin
      @user.is_admin = !@user.is_admin
      if @user.save
        redirect_to @user, notice: 'Admin status updated.'
      else
        render :show
      end        
    end
  end
  
  private

    def generate_error_csv(error_rows)
      CSV.generate(headers: true) do |csv|
        csv << ["email", "forename", "surname", "insurer", "vehicle_registration", "address", "telephone_number",  "Response"]
        error_rows.each do |row|
          csv << [row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7]]
        end
      end
    end

    def set_user
      if current_user.is_admin?
        @user = User.unscoped.find(params[:id])
      else
        @user = User.find(params[:id])
      end
    end

    def user_params
      if current_user.is_admin?
        params.require(:user).permit(:email, :password, :forename, :surname, :title_id, :address, :vehicle_registration, :insurer, :telephone_number, :is_admin, :company_id, :promo_code, :call_on_false_alarm, { company_users_attributes: [:id, :create_license, :is_company_admin, :start_date, :end_date]})
      elsif is_company_admin? == true
        params.require(:user).permit(:email, :password_digest, :forename, :surname, :title_id, :address, :vehicle_registration, :insurer, :telephone_number, :call_on_false_alarm, { company_users_attributes: [:id, :create_license, :is_company_admin, :start_date, :end_date]})
      else
        params.require(:user).permit(:email, :password_digest, :forename, :surname, :title_id, :address, :vehicle_registration, :insurer, :telephone_number, :call_on_false_alarm)
      end
    end
end

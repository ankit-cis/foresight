class SettingsController < ApplicationController
  before_action :authorize
  before_action :admin_required
  before_action :set_setting, only: [:index, :show, :edit, :update, :destroy, :reset_all_passwords]
  
  # GET /settings
  # GET /settings.json
  def index
    @setting ||= Setting.new()
    render :show
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
  end

  # GET /settings/new
  def new
    @setting = Setting.new
  end

  # GET /settings/1/edit
  def edit
  end

  # POST /settings
  # POST /settings.json
  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url, notice: 'Setting was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def reset_all_passwords
    
    users = User.all
    users.each do |user|
      user.set_password_reset_token
      user.save!
      
      SettingsMailer.upgrade_reset(user.id).deliver_later
    end
    
    redirect_to @setting, notice: 'All passwords being reset.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:company_id, :notification_email, :disable_user_emails)
    end
end

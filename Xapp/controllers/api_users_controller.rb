class ApiUsersController < ApplicationController
  before_action :authorize
  before_action :admin_required
  before_action :set_api_user, only: [:index, :show, :edit, :update, :destroy]
  
  # GET /api_users
  # GET /api_users.json
  def index
    render :show
  end

  # GET /api_users/1
  # GET /api_users/1.json
  def show
  end

  # GET /api_users/new
  def new
    @api_user = ApiUser.new
  end

  # GET /api_users/1/edit
  def edit
  end

  # POST /api_users
  # POST /api_users.json
  def create
    @api_user = ApiUser.new(api_user_params)

    respond_to do |format|
      if @api_user.save
        format.html { redirect_to @api_user, notice: 'ApiUser was successfully created.' }
        format.json { render :show, status: :created, location: @api_user }
      else
        format.html { render :new }
        format.json { render json: @api_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api_users/1
  # PATCH/PUT /api_users/1.json
  def update
    respond_to do |format|
      if @api_user.update(api_user_params)
        format.html { redirect_to @api_user, notice: 'ApiUser was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_user }
      else
        format.html { render :edit }
        format.json { render json: @api_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api_users/1
  # DELETE /api_users/1.json
  def destroy
    @api_user.destroy
    respond_to do |format|
      format.html { redirect_to api_users_url, notice: 'ApiUser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_user
      @api_user = ApiUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_user_params
      params.require(:api_user).permit(:company_id, :notification_email, :disable_user_emails)
    end
end

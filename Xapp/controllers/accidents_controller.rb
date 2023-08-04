class AccidentsController < ApplicationController
  before_action :authorize
  before_action :company_admin_required
  before_action :set_accident, only: [:show, :edit, :update, :destroy]
  
  # GET /accidents
  # GET /accidents.json
  def index
    @accidents = Accident.company_secure.all.order(created_at: :desc).page params[:page]
    
    if current_user.is_admin
      @search = Accident.ransack(params[:q])
    else
      @search = Accident.company_secure.ransack(params[:q])
    end
    if params[:paged] == "false"
      @accidents = @search.result.includes(:user, :video).order(created_at: :desc)
    else
      @accidents = @search.result.includes(:user, :video).order(created_at: :desc).page params[:page]
    end
    if params[:q]
      @active_search = true
    else
      @active_search = false
    end
  end

  # GET /accidents/1
  # GET /accidents/1.json
  def show
  end

  # GET /accidents/new
  def new
    @accident = Accident.new
  end

  # GET /accidents/1/edit
  def edit
  end

  # POST /accidents
  # POST /accidents.json
  def create
    @accident = Accident.new(accident_params)

    respond_to do |format|
      if @accident.save
        format.html { redirect_to @accident, notice: 'Accident was successfully created.' }
        format.json { render :show, status: :created, location: @accident }
      else
        format.html { render :new }
        format.json { render json: @accident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accidents/1
  # PATCH/PUT /accidents/1.json
  def update
    respond_to do |format|
      if @accident.update(accident_params)
        
        if !@accident.video.nil? && (@accident.video.status_id != @accident.status_id)
          video = @accident.video
          video.status_id = @accident.status_id
          video.save!
        end
        
        format.html { redirect_to @accident, notice: 'Accident was successfully updated.' }
        format.json { render :show, status: :ok, location: @accident }
      else
        format.html { render :edit }
        format.json { render json: @accident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accidents/1
  # DELETE /accidents/1.json
  def destroy
    @accident.destroy
    respond_to do |format|
      format.html { redirect_to accidents_url, notice: 'Accident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accident
      @accident = Accident.company_secure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accident_params
      params.require(:accident).permit(:user_id, :company_id, :lat, :long, :video_id, :status_id)
    end
end

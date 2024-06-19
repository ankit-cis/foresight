class VideosController < ApplicationController
  before_action :authorize
  before_action :company_admin_required
  before_action :set_video, only: [:show, :edit, :update, :destroy, :subtitles]


  def index
    if current_user.is_admin
      @search = Video.where.not(user_id: 'b57cb701-1a37-4ddc-89a8-8703b37f9b16').ransack(params[:q])
    else
      @search = Video.where.not(user_id: 'b57cb701-1a37-4ddc-89a8-8703b37f9b16').company_secure.ransack(params[:q])
    end
    if params[:paged] == "false"
      @videos = @search.result.includes(:user, :accident).order(created_at: :desc)
    else
      @videos = @search.result.includes(:user, :accident).order(created_at: :desc).page params[:page]
    end
    if params[:q]
      @active_search = true
    else
      @active_search = false
    end
  end

  def show
  end

  def new
    @video = Video.new
  end

  def edit
  end

  def create
    @video = Video.build(video_params)
    unless ['United Kingdom', 'England'].include?(params['country'])
      @video.lat = 53.614345750544985
      @video.long = -2.1519367845205943
    end
    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @video.update(video_params)
        if !@video.accident.nil? && (@video.status_id != @video.accident.status_id)
          accident = @video.accident
          accident.status_id = @video.status_id
          accident.save!
        end
        
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def subtitles
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.company_secure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:user_id, :company_id, :lat, :long, :accident_id, :video_data, :status_id)
    end
end

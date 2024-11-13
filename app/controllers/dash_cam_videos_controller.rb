require 'open-uri'

class DashCamVideosController < ApplicationController

    def index
        @dashcam_videos = DashCamVideo.order(created_at: :desc) # You can adjust the order as needed

    end

     # Method to serve video files from the server
  def show
    video = DashCamVideo.find(params[:id])
    file_path = Rails.root.join('public', video.file_path)

    if File.exist?(file_path)
      send_file(file_path, type: 'video/mp4', disposition: 'inline')
    else
      render plain: "Video file not found", status: :not_found
    end
  end
    
    def create
        debugger
        # dash_cam_video = DashCamVideo.new
        # uploaded_file = params[:file] # Access the uploaded file

        # # Set file details using CarrierWave and additional fields
        # dash_cam_video.video = uploaded_file # This assigns the uploaded file to CarrierWave's `video` uploader
        # dash_cam_video.file_name = uploaded_file.original_filename
        # dash_cam_video.file_path = dash_cam_video.video.url # URL or path to where the file is stored
        # dash_cam_video.uploaded_at = Time.current

        # if dash_cam_video.save
        # render json: { message: 'File uploaded successfully', file_url: dash_cam_video.video.url }, status: :ok
        # else
        # render json: { error: 'Failed to save file' }, status: :unprocessable_entity
        # end

        file_url = params[:file_url]
    filename = params[:filename]

    if file_url.blank? || filename.blank?
      render json: { error: 'File URL and filename are required' }, status: :unprocessable_entity
      return
    end

    # Check if the file already exists
    if DashCamVideo.exists?(file_name: filename)
      render json: { message: 'File already exists' }, status: :ok
      return
    end

    # Download the file from the provided URL
    file_data = URI.open(file_url) { |f| f.read }
    
    # Use CarrierWave or ActiveStorage to save the file
    dash_cam_video = DashCamVideo.new(file_name: filename)
    dash_cam_video.video = StringIO.new(file_data)
    
    if dash_cam_video.save
      render json: { message: 'File uploaded successfully', file_url: dash_cam_video.video.url }, status: :ok
    else
      render json: { error: 'Failed to save file' }, status: :unprocessable_entity
    end
    end

      # DELETE /dash_cam_videos/:id
  def destroy
    # Delete the file from the file system

    @dash_cam_video = DashCamVideo.find(params[:id]) 
    file_path = Rails.root.join('public', 'uploads', 'dash_cam_videos', @dash_cam_video.file_name)
    File.delete(file_path) if File.exist?(file_path)

    # Delete the database record
    @dash_cam_video.destroy

    flash[:notice] = "Video deleted successfully."
    redirect_to dash_cam_videos_path
  end
end

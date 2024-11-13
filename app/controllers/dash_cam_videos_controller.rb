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

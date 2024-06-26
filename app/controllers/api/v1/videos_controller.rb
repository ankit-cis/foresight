module Api
  module V1
    class VideosController < ApiApplicationController
      before_action :authorize
      before_action :set_video, only: [:update, :show]
        
      def create
        @video = current_user.videos.build(video_params)
        
        @video.user = current_user
        
        @video.status = Status.find_by_status_constant('REPORTED')
        
        @video.company = current_user.company

        @video.user_device = current_user_device

        if !(params["country"] == "United Kingdom" || params["country"] == "England")
          @video.lat = 53.614345750544985
          @video.long = -2.1519367845205943
        end
        
        if @video.save
          if !params[:speeds].nil?
            params[:speeds].each do |speed|
              new_speed = @video.speeds.build
              new_speed.start_time = speed["start_time"]
              new_speed.end_time = speed["end_time"]
              new_speed.speed = speed["speed"]
              new_speed.save!
            end
          end
          
          if !params[:gforces].nil?
            params[:gforces].each do |gforce|
              new_gforce = @video.gforces.build
              new_gforce.forward_force = gforce["forward_force"]
              new_gforce.side_force = gforce["side_force"]
              new_gforce.vertical_force = gforce["vertical_force"]
              new_gforce.detected_time = gforce["detected_time"]
              new_gforce.save!
            end
          end
                    
          VideoMailer.new_video_uploaded(@video.id).deliver_later
          
          render :create, status: :created
        else
          render :json => { :errors => @video.errors.full_messages }, :status => :unprocessable_entity
        end
      end

      def update
        if @video.update(video_params)
          if !params[:speeds].nil?
            params[:speeds].each do |speed|
              new_speed = @video.speeds.build
              new_speed.start_time = speed["start_time"]
              new_speed.end_time = speed["end_time"]
              new_speed.speed = speed["speed"]
              new_speed.save!
            end
          end
          
          if !params[:gforces].nil?
            params[:gforces].each do |gforce|
              new_gforce = @video.gforces.build
              new_gforce.forward_force = gforce["forward_force"]
              new_gforce.side_force = gforce["side_force"]
              new_gforce.vertical_force = gforce["vertical_force"]
              new_gforce.detected_time = gforce["detected_time"]
              new_gforce.save!
            end
          end
          render :create, status: :ok
        else
          render :json => { :errors => @video.errors.full_messages }, :status => :unprocessable_entity
        end
      end

      def show
        render :create, status: :ok
      end
      
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_video
          @video = current_user.videos.unscoped.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def video_params
          params.require(:video).permit(:user_id, :lat, :long, :accident_id, :incident_video, :speeds, :crash_detected_time, :forward_force, :side_force, :vertical_force,  :app_version, :system_name, :system_version, :device_model, :recording_start_time, :false_alarm)
        end
    end
  end
end

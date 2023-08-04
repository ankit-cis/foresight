module Api
  module V1
    class PhotosController < ApiApplicationController
      before_action :authorize
      
      def create
        accident = current_user.accidents.find(params[:accident_id])
        
        @photo = accident.photos.build(photo_params)
        if @photo.save
          render :create, status: :created
        else
          render :json => { :errors => @photo.errors.full_messages }, :status => :unprocessable_entity
        end
      end

      private

        # Never trust parameters from the scary internet, only allow the white list through.
        def photo_params
          params.require(:photo).permit(:accident_id ,:accident_image)
        end
    end
  end
end

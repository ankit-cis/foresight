module Api
  module V1
    class AccidentsController < ApiApplicationController
      before_action :authorize
      before_action :set_accident, only: [:update]

      def create
        @accident = current_user.accidents.build(accident_params.except(:video_id))

        @accident.user = current_user

        @accident.status = Status.find_by_status_constant('REPORTED')

        @accident.company = current_user.company

        if !(params["country"] == "United Kingdom" || params["country"] == "England")
          @video.lat = 53.614345750544985
          @video.long = -2.1519367845205943
        end

        if @accident.save
          video = Video.find(accident_params[:video_id])
          video.accident = @accident
          video.company =  @accident.company
          video.save!

          AccidentMailer.new_accident_uploaded(@accident.id).deliver_now

          render :create, status: :created
        else
          render json: { errors: @accident.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @accident.update(accident_params)
          render :create, status: :ok
        else
          render json: { errors: @accident.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_accident
        @accident = current_user.accidents.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def accident_params
        params.require(:accident).permit(:video_id, :lat, :long, :registration_number,
                                         witnesses_attributes: %i[name telephone_number
                                                                  addresspostcode],
                                         vehicles_attributes: %i[registration_number
                                                                 driver_name insurance_company
                                                                 phone_number])
      end
    end
  end
end

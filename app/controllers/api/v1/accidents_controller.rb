module Api
  module V1
    class AccidentsController < ApiApplicationController
      before_action :authorize
      before_action :set_accident, only: [:update]

      def create
        @accident = current_user.accidents.build(accident_params.except(:video_ids))

        @accident.user = current_user
        @accident.status = Status.find_by_status_constant('REPORTED')
        @accident.company = current_user.company

        if !(params["accident"]["country"] == "United Kingdom" || params["accident"]["country"] == "England")
          @accident.lat = 53.614345750544985
          @accident.long = -2.1519367845205943
        end

        if @accident.save
          video_ids = accident_params[:video_ids]
          if video_ids.present?
            videos = Video.where(id: video_ids)
            videos.each do |video|
              video.update!(accident: @accident, company: @accident.company)
            end
          end

          AccidentMailer.new_accident_uploaded(@accident.id).deliver_later
          AccidentMailer.user_confirmation_new_accident(current_user.id).deliver_later

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
        params.require(:accident).permit(video_ids: [], :lat, :long, :registration_number,
                                         witnesses_attributes: %i[name telephone_number
                                                                  addresspostcode],
                                         vehicles_attributes: %i[registration_number
                                                                 driver_name insurance_company
                                                                 phone_number])
      end
    end
  end
end

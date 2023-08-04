module Api
  module V1
    class VehiclesController < ApiApplicationController
      before_action :authorize
      before_action :set_vehicle, only: [:update]
      
      def create
        accident = current_user.accidents.find(params[:accident_id])
        
        if params.has_key?("vehicles")
          params["vehicles"].each do |vehicle|
            @vehicle = accident.vehicles.build(vehicle_params(vehicle))
            if !@vehicle.save
              render :json => { :errors => @vehicle.errors.full_messages }, :status => :unprocessable_entity
            end
          end

          render :json => { :status => "created" }, status: :created

        else
          @vehicle = accident.vehicles.build(vehicle_params(params["vehicle"]))
          if @vehicle.save
            render :create, status: :created
          else
            render :json => { :errors => @vehicle.errors.full_messages }, :status => :unprocessable_entity
          end

        end                
      end

      def update
        if @vehicle.update(vehicle_params)
          render :create, status: :ok
        else
          render :json => { :errors => @vehicle.errors.full_messages }, :status => :unprocessable_entity
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_vehicle
          @vehicle = current_user.vehicles.unscoped.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def vehicle_params(vehicle)
          vehicle.permit!
        end
    end
  end
end

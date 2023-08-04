module Api
  module V1
    class WitnessesController < ApiApplicationController
      before_action :authorize
      
      def create
        accident = current_user.accidents.find(params[:accident_id])
        
        if params.has_key?("witnesses")
          params["witnesses"].each do |witness|
            @witness = accident.witnesses.build(witness_params(witness))
            if !@witness.save
              render :json => { :errors => @witness.errors.full_messages }, :status => :unprocessable_entity
            end
          end

          render :json => { :status => "created" }, status: :created

        else
          @witness = accident.witnesses.build(vehicle_params(params["witness"]))
          if @witness.save
            render :create, status: :created
          else
            render :json => { :errors => @witness.errors.full_messages }, :status => :unprocessable_entity
          end

        end            
      end

      private

        # Never trust parameters from the scary internet, only allow the white list through.
        def witness_params(witness)
          witness.permit!
        end
    end
  end
end

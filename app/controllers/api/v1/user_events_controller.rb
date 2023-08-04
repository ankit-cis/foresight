module Api
  module V1
    class UserEventsController < ApiApplicationController
      before_action :authorize
      
      def create
        @user_event = current_user.user_events.build(user_event_params)
        
        @user_event.user_device = current_user_device
        
        @user_event.event_type = EventType.find_by_event_type_const(@user_event.event_type_const)
        
        if @user_event.save
          render :show, status: :created
        else
          render json: @user_event.errors, status: :unprocessable_entity
        end
      end

      private
        def user_event_params
          params.require(:user_event).permit(:event_type_const, :description, :event_time)
        end
    end
  end
end

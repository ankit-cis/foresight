module Api
  module V1
    class MessagesController < ApiApplicationController
      before_action :authorize

      # GET /messages
      # GET /messages.json
      def index
        @messages = Message.where("company_id = '#{current_user.company_id}' and expires >= '#{Date.today.strftime("%Y-%m-%d")}'")
      end
    end
  end
end

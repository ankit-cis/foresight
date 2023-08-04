module Api
  module V1
    class WebsiteVersionController < ApiApplicationController
      def index
        render :json => { :version => Rails.configuration.website_version }, :status => :ok
      end
    end
  end
end
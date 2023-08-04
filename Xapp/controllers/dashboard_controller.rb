class DashboardController < ApplicationController
  before_action :authorize
  
  def index
    @accident_count = Accident.company_secure.count
    @video_count = Video.company_secure.count
    @company_count = Company.count
    @user_count = User.company_secure.count
  end
end

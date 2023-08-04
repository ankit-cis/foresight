class DashboardController < ApplicationController
  before_action :authorize
  
  def index
    @accident_count = Accident.where.not(user_id: "b57cb701-1a37-4ddc-89a8-8703b37f9b16").company_secure.count
    @video_count = Video.where.not(user_id: "b57cb701-1a37-4ddc-89a8-8703b37f9b16").company_secure.count
    @company_count = Company.where.not(user_id: "b57cb701-1a37-4ddc-89a8-8703b37f9b16").count
    @user_count = User.where.not(id: "b57cb701-1a37-4ddc-89a8-8703b37f9b16").company_secure.count
  end
end

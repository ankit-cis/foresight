class ReportsController < ApplicationController
  before_action :authorize
  before_action :admin_required

  def index
  end
end

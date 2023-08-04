class UserDevicesController < ApplicationController
  before_action :authorize
  before_action :company_admin_required
  before_action :set_user
  before_action :set_user_device, only: [:show, :edit, :update, :destroy]

  # def index
  #   @user_devices = UserDevice.all
  # end

  def show
    @user_events = @user_device.user_events.order('event_time DESC').page params[:page]
  end

  def destroy
    @user_device.destroy
    respond_to do |format|
      format.html { redirect_to user_devices_url, notice: 'User device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user =  User.company_secure.find(params[:user_id])
    end
    def set_user_device
      @user_device = UserDevice.company_secure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_device_params
      params.fetch(:user_device, {})
    end
end

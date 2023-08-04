class MessagesController < ApplicationController
  before_action :authorize
  before_action :set_message, only: [:show, :edit, :update, :destroy, :send_message]

  before_action :company_admin_required

  # GET /messages
  # GET /messages.json
  def index
    if current_user.is_admin
      @messages = Message.all.page params[:page]
    else
      @messages = Message.company_secure.page params[:page]
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    
    if !current_user.is_admin?
      @message.company = current_company
    end
    
    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def send_message
    iphone_notification = {
        aps: {
            alert: {title: @message.title, body: @message.body}, sound: "default", extra:  {message_id: @message.id, notification_type: "MESSAGE"}
        }
    }
    
    android_message = {
      data: {message: @message.title, body: @message.body, message_id: @message.id, notification_type: "MESSAGE"}
    }
    
    sns_message = {
        default: @message.body,
        APNS_SANDBOX: iphone_notification.to_json,
        APNS: iphone_notification.to_json,
        GCM: android_message.to_json
    }
    
    sns = Aws::SNS::Client.new
    @message.company.users.each do |user|
      user.user_devices.each do |user_device|
          
        if user_device.endpoint_arn != nil
        
          begin
            sns.publish(target_arn: user_device.endpoint_arn, message: sns_message.to_json, message_structure:"json")
          rescue Aws::SNS::Errors::EndpointDisabled
            user_device.endpoint_arn = nil
            user_device.save!
          rescue Aws::SNS::Errors::InvalidParameter
            user_device.endpoint_arn = nil
            user_device.save!
          end                    
        end
      end
    end
    redirect_to messages_path, notice: "Message will be sent to all registered devices"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      if current_user.is_admin?
        @message = Message.unscoped.find(params[:id])
      else
        @message = Message.company_secure.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:company_id, :title, :body, :content, :expires)
    end
end

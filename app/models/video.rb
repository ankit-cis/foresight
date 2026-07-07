class Video < ApplicationRecord  
  mount_uploader :incident_video, IncidentVideoUploader

  # store_in_background :incident_video

  before_save :check_new_status
  
  belongs_to :user
  
  belongs_to :company
  belongs_to :accident
  belongs_to :status
  belongs_to :user_device

  has_many :speeds, dependent: :destroy
  has_many :gforces, dependent: :destroy
  
  accepts_nested_attributes_for :speeds
  accepts_nested_attributes_for :gforces

  def self.company_secure
    if Company.is_admin == false
      where(company_id: Company.current_id)
    else
      all
    end
  end  

  def check_new_status
    if status.status_constant == "ACTIONED_FALSE_ALARM"
      settings = self.company.setting
      if settings&.disable_user_emails != true
        StatusMailer.false_alarm(user.id).deliver_later
      end
    end
  end
  
  def presigned_url
    incident_video&.url
  end

  def presigned_get_url
    incident_video&.url
  end
end

class UserDevice < ApplicationRecord
  belongs_to :user
  
  has_many :videos
  
  has_many :user_events
  
  def self.company_secure
    if Company.is_admin == false
      where(company_id: Company.current_id)
    else
      all
    end
  end  
  
end

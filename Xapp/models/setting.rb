class Setting < ApplicationRecord
  belongs_to :company
  
  def self.company_secure
    if Company.is_admin == false
      where(company_id: Company.current_id)
    else
      all
    end
  end  
  
end

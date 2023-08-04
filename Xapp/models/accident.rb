class Accident < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :video
  belongs_to :status

  has_many :vehicles, inverse_of: :accident
  has_many :photos, inverse_of: :accident
  has_many :witnesses, inverse_of: :accident
  
  accepts_nested_attributes_for :vehicles, :allow_destroy => true
  accepts_nested_attributes_for :photos, :allow_destroy => true
  accepts_nested_attributes_for :witnesses, :allow_destroy => true
  
  def self.company_secure
    if Company.is_admin == false
      where(company_id: Company.current_id)
    else
      all
    end
  end  

end

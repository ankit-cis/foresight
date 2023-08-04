class Message < ApplicationRecord
  belongs_to :company

  belongs_to :unscoped_company, -> { unscoped }, foreign_key: :company_id, class_name: "Company"

  validates_presence_of :company, :on => :create, :message => "can't be blank"
  
  def self.company_secure
    if Company.is_admin == false
      where(company_id: Company.current_id)
    else
      all
    end
  end  
end

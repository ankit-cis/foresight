class CompanyUser < ApplicationRecord
  belongs_to :company
  belongs_to :user

  attr_accessor :create_license
  
  scope :active, lambda { where("(company_users.start_date <= ? or company_users.start_date is null) and (company_users.end_date >= ? or company_users.end_date is null)", Date.today, Date.today) }
  
end

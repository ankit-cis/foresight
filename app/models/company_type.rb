class CompanyType < ApplicationRecord
  has_many :companies

  def self.unique_by_name
    order(:name).to_a.uniq { |company_type| company_type.name }
  end
end

class PaymentType < ApplicationRecord
  has_many :companies

  def self.unique_by_name
    order(:name).to_a.uniq { |payment_type| payment_type.name }
  end
end

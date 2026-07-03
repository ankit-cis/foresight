class Title < ApplicationRecord
  has_many :users

  def self.unique_by_name
    order(:name).to_a.uniq { |title| title.name }
  end
end

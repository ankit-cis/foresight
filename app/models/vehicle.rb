class Vehicle < ApplicationRecord
  belongs_to :accident, inverse_of: :vehicles
end

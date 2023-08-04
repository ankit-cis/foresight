class Witness < ApplicationRecord
  belongs_to :accident, inverse_of: :witnesses
end

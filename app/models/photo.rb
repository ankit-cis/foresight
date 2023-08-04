class Photo < ApplicationRecord
  mount_uploader :accident_image, AccidentImageUploader

  belongs_to :accident, inverse_of: :photos
end

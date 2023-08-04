class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :user_device
  belongs_to :event_type
end

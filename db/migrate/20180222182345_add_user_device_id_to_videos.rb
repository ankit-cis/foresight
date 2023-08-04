class AddUserDeviceIdToVideos < ActiveRecord::Migration[5.1]
  def change
    add_reference :videos, :user_device, type: :uuid, foreign_key: true
  end
end

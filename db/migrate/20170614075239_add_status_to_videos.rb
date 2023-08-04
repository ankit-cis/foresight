class AddStatusToVideos < ActiveRecord::Migration[5.1]
  def change
    add_reference :videos, :status, type: :uuid, foreign_key: true
  end
end

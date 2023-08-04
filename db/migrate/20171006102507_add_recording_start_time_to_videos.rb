class AddRecordingStartTimeToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :recording_start_time, :datetime
  end
end

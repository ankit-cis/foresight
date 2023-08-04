class AddCrashDetectedTimestampVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :crash_detected_time, :datetime
  end
end

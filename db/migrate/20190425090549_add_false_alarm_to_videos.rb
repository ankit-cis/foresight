class AddFalseAlarmToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :false_alarm, :boolean
  end
end

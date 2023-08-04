class AddIncidentVideoTmpToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :incident_video_tmp, :string
    add_column :videos, :incident_video_processing, :boolean, null: false, default: false
  end
end

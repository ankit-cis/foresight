class AddFileNameToDashCamVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :dash_cam_videos, :file_name, :string
    add_column :dash_cam_videos, :file_path, :string
    add_column :dash_cam_videos, :uploaded_at, :datetime
  end
end

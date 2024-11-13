class CreateDashCamVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :dash_cam_videos do |t|
      t.string :video

      t.timestamps
    end
  end
end

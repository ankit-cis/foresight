class RemoveVideoIdColumnFromAccidents < ActiveRecord::Migration[5.1]
  def change
    remove_column :accidents, :video_id
  end
end

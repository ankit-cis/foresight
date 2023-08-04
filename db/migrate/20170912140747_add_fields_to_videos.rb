class AddFieldsToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :app_version, :string
    add_column :videos, :system_name, :string
    add_column :videos, :system_version, :string
    add_column :videos, :device_model, :string
  end
end

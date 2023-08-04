class AddGForceDetailsToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :forward_force, :float
    add_column :videos, :side_force, :float
    add_column :videos, :vertical_force, :float
  end
end

class AddAccidentToVideos < ActiveRecord::Migration[5.1]
  def change
    add_reference :videos, :accident, type: :uuid, foreign_key: true
  end
end

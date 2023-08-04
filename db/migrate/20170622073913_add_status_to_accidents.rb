class AddStatusToAccidents < ActiveRecord::Migration[5.1]
  def change
    add_reference :accidents, :status, type: :uuid, foreign_key: true
  end
end

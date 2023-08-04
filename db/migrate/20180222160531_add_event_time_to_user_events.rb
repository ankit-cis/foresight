class AddEventTimeToUserEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :user_events, :event_time, :datetime
  end
end

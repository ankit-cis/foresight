class AddEventTypeIdToUserEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_events, :event_type, type: :uuid, foreign_key: true
  end
end

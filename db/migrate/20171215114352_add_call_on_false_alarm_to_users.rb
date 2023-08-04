class AddCallOnFalseAlarmToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :call_on_false_alarm, :boolean
  end
end

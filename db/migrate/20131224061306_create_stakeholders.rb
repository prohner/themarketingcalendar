class CreateStakeholders < ActiveRecord::Migration
  def change
    create_table :stakeholders do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :reminder_notification_days

      t.timestamps
    end
  end
end

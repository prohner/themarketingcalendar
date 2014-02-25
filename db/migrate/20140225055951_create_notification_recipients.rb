class CreateNotificationRecipients < ActiveRecord::Migration
  def change
    create_table :notification_recipients do |t|
      t.string :email
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end

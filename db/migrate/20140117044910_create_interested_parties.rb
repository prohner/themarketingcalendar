class CreateInterestedParties < ActiveRecord::Migration
  def change
    create_table :interested_parties do |t|
      t.string :email

      t.timestamps
    end
    
    add_column :users, :user_type, :integer
    
  end
end

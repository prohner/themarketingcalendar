class AddUserTypeToShare < ActiveRecord::Migration
  def change
    add_column :shares, :user_type, :integer
  end
end

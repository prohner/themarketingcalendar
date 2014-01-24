class AddUserIdToCategoryGroup < ActiveRecord::Migration
  def change
    add_column :category_groups, :user_id, :integer
  end
end

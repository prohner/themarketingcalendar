class AddCategoryGroupIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :group_category_id, :integer    
  end
end

class RenameGroupCategoryIdOnCategory < ActiveRecord::Migration
  def change
    rename_column :categories, :group_category_id, :category_group_id
  end
end

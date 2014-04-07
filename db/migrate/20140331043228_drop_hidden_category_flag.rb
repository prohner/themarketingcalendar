class DropHiddenCategoryFlag < ActiveRecord::Migration
  def change
    drop_table :hidden_category_flags
  end
end

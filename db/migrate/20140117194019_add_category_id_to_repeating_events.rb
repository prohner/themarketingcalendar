class AddCategoryIdToRepeatingEvents < ActiveRecord::Migration
  def change
    add_column :repeating_events, :category_id, :integer
  end
end

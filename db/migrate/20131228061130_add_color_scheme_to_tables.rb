class AddColorSchemeToTables < ActiveRecord::Migration
  def change
    remove_column :categories, :color
    remove_column :category_groups, :color
    
    add_column :categories, :color_scheme_id, :integer
    add_column :category_groups, :color_scheme_id, :integer
    
  end
end

class AddNameToColorScheme < ActiveRecord::Migration
  def change
    add_column :color_schemes, :name, :string
  end
end

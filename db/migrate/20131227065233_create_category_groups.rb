class CreateCategoryGroups < ActiveRecord::Migration
  def change
    create_table :category_groups do |t|
      t.integer :company_id
      t.string :description
      t.string :color

      t.timestamps
    end
  end
end

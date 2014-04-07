class CreateHiddenCategoryGroupFlags < ActiveRecord::Migration
  def change
    create_table :hidden_category_group_flags do |t|
      t.integer :category_group_id
      t.integer :user_id

      t.timestamps
    end
  end
end

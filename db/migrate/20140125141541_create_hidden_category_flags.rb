class CreateHiddenCategoryFlags < ActiveRecord::Migration
  def change
    create_table :hidden_category_flags do |t|
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end

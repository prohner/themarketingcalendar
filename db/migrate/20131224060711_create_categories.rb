class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :description
      t.integer :company_id
      t.string :color

      t.timestamps
    end
  end
end

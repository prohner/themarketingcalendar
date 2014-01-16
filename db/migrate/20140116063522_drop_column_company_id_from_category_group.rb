class DropColumnCompanyIdFromCategoryGroup < ActiveRecord::Migration
  def change
    remove_column :category_groups, :company_id
  end
end

class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :owner_id
      t.integer :partner_id
      t.integer :category_group_id

      t.timestamps
    end
  end
end

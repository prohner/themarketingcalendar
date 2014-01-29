class AddUuidToShare < ActiveRecord::Migration
  def change
    add_column :shares, :uuid, :string
  end
end

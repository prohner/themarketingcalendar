class RemoveStatusFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :status, :string
  end
end

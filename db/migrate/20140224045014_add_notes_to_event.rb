class AddNotesToEvent < ActiveRecord::Migration
  def change
    add_column :events, :notes, :string
  end
end

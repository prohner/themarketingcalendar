class RenameEventDatesOnEvent < ActiveRecord::Migration
  def change
    rename_column :events, :start_date, :starts_at
    rename_column :events, :end_date, :ends_at
  end
end

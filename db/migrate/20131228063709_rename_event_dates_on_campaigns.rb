class RenameEventDatesOnCampaigns < ActiveRecord::Migration
  def change
    rename_column :campaigns, :start_date, :starts_at
    rename_column :campaigns, :end_date, :ends_at
  end
end

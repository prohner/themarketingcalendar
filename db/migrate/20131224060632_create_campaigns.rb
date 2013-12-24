class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :description
      t.date :start_date
      t.date :end_date
      t.integer :company_id
      t.string :color

      t.timestamps
    end
  end
end

class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.date :start_date
      t.date :end_date
      t.integer :campaign_id
      t.integer :category_id
      t.string :repetition_type
      t.integer :repetition_frequency
      t.boolean :on_sunday
      t.boolean :on_monday
      t.boolean :on_tuesday
      t.boolean :on_wednesday
      t.boolean :on_thursday
      t.boolean :on_friday
      t.boolean :on_saturday
      t.string :repetition_options

      t.timestamps
    end
  end
end

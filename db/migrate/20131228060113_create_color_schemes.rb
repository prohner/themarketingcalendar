class CreateColorSchemes < ActiveRecord::Migration
  def change
    create_table :color_schemes do |t|
      t.string :foreground
      t.string :background

      t.timestamps
    end
  end
end

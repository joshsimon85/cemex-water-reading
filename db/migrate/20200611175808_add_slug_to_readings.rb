class AddSlugToReadings < ActiveRecord::Migration[6.0]
  def change
    add_column :water_meter_readings, :slug, :string
    add_index :water_meter_readings, :slug, unique: true
  end
end

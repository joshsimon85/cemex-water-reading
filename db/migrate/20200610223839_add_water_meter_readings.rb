class AddWaterMeterReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :water_meter_readings do |t|
      t.belongs_to :user
      t.decimal :reading, null: false
      t.timestamps null: false
    end
  end
end

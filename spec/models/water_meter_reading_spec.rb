require 'rails_helper'

RSpec.describe WaterMeterReading do
  it { should validate_presence_of(:reading) }
  it { should validate_presence_of(:image) }
  it { should belong_to(:user) }
  it { should validate_numericality_of(:reading) }

  it 'should return the readings in created at order desc' do
    user = create(:user)
    reading_1 = create(:water_meter_reading,
                       :with_image, user_id: user.id,
                       created_at: Time.now)
    reading_2 = create(:water_meter_reading,
                       :with_image, user_id: user.id,
                       created_at: Time.now + 1.hour)
    reading_3 = create(:water_meter_reading,
                       :with_image, user_id: user.id,
                       created_at: Time.now + 2.hour)

    expect(WaterMeterReading.all).to eq([reading_3, reading_2, reading_1])
  end
end

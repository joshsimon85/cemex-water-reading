require 'rails_helper'

RSpec.describe WaterMeterReading do
  it { should validate_presence_of(:reading) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:image) }
end

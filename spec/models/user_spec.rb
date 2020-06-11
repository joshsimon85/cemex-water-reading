require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:email) }
  it { should have_many(:water_meter_readings) }
  
  describe '#admin?' do
    it 'returns false when the user is not an admin' do
      user = build(:user)
      expect(user.admin?).to be(false)
    end

    it 'returns true when the user is an admin' do
      user = build(:user, admin: true)
      expect(user.admin?).to be(true)
    end
  end
end

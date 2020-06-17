require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:email) }
  it { should have_many(:water_meter_readings) }
  it { should have_many(:invitations) }

  it 'returns the users in asc order based on full name' do
    user_1 = create(:user, full_name: 'Anthony A')
    user_3 = create(:user, full_name: 'Bethony A')
    user_2 = create(:user, full_name: 'Anthony B')

    expect(User.all).to eq([user_1, user_2, user_3])
  end

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

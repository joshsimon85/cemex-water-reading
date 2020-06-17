require 'rails_helper'

RSpec.describe Invitation do
  let(:user) { create(:user) }

  subject { create(:invitation, user_id: user.id) }

  it { should belong_to(:user) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:token) }

  it 'should return the invitaions in created at order desc' do
    user = create(:user)
    invite_1 = create(:invitation, user_id: user.id, created_at: Time.now)
    invite_2 = create(:invitation, user_id: user.id,
                      created_at: Time.now + 1.hour)
    invite_3 = create(:invitation, user_id: user.id,
                      created_at: Time.now + 2.hour)

    expect(Invitation.all).to eq([invite_3, invite_2, invite_1])
  end
end

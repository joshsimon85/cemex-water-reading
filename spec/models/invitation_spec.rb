require 'rails_helper'

RSpec.describe Invitation do
  let(:user) { create(:user) }

  subject { create(:invitation, user_id: user.id) }

  it { should belong_to(:user) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:token) }
end

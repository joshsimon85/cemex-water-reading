require 'rails_helper'

RSpec.describe Invitation do
  it { should belong_to(:user) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:token) }
end

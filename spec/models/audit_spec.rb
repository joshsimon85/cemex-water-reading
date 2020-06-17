require 'rails_helper'

RSpec.describe Audit do
  it { should validate_presence_of(:created_by) }
  it { should validate_presence_of(:action_type) }
  it { should validate_presence_of(:record_type) }
  it { should validate_presence_of(:record_id) }
  
  it 'returns a list of audits in desc order based on created on' do
    audit_1 = create(:audit, created_at: Time.now)
    audit_2 = create(:audit, created_at: Time.now + 1.hour)
    audit_3 = create(:audit, created_at: Time.now + 2.hour)

    expect(Audit.all).to eq([audit_3, audit_2, audit_1])
  end
end

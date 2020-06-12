require 'rails_helper'

RSpec.describe DeactivationsController do
  let(:active_user) { create(:user) }
  let(:suspended_user) { create(:user, suspended: false) }

  describe 'POST create' do
    it_behaves_like 'requires sign in' do
      let(:action) { post :create, slug: active_user.slug  }
    end

    it_behaves_like 'requires signed in admin' do
      let(:action) { post :create, slug: active_user.slug }
    end
  end
end

require 'rails_helper'

RSpec.describe InvitationsController do
  describe 'GET new' do
    it_behaves_like 'requires signed in admin' do
      let(:action) { get :new }
    end

    it_behaves_like 'requires sign in' do
      let(:action) { get :new }
    end
  end
end

require 'rails_helper'

RSpec.describe AuditsController do
  describe 'GET index' do
    it_behaves_like 'requires sign in' do
      let(:action) { get :index }
    end

    it_behaves_like 'requires signed in admin' do
      let(:action) { get :index }
    end

    context 'with signed in admin' do
      let(:admin) { create(:user, admin: true) }

      before do
        sign_in(admin)
        get :index
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end
  end
end

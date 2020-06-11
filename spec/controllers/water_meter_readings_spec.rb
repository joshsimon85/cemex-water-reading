require 'rails_helper'

RSpec.describe WaterMeterReadingsController do
  let(:admin) { create(:user, admin: true) }
  let(:reading) { create(:water_meter_reading, :with_image, user: admin) }
  
  describe 'GET index' do
    it_behaves_like 'requires sign in' do
      let(:action) { get :index }
    end

    context 'with logged in user' do

    end

    context 'with logged in admin' do
      it 'renders the index template' do
        sign_in(admin)

        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET show' do
    it_behaves_like 'requires sign in' do
      let(:action) { get :show, params: { slug: reading.slug } }
    end

    it 'renders the show template' do
      sign_in(admin)

      get :show, params: { slug: reading.slug }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET update' do
    it_behaves_like 'requires sign in' do
      let(:action) { get :update, params: { slug: reading.slug } }
    end
  end
end

require 'rails_helper'

RSpec.describe WaterMeterReadingsController do
  describe 'GET index' do
    
    context 'with logged in user' do

    end

    context 'with logged in admin' do
      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end
end

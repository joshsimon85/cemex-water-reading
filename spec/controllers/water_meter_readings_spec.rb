require 'rails_helper'

RSpec.describe WaterMeterReadingsController do
  let(:admin) { create(:user, admin: true) }
  let(:reading) {
    create(:water_meter_reading, :with_image, user: admin, reading: 1)
  }

  describe 'GET index' do
    it_behaves_like 'requires sign in' do
      let(:action) { get :index }
    end

    it_behaves_like 'requires signed in admin' do
      let(:action) { get :index }
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

    it_behaves_like 'requires signed in admin' do
      let(:action) { get :show, params: { slug: reading.slug } }
    end

    it 'renders the show template' do
      sign_in(admin)

      get :show, params: { slug: reading.slug }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET edit' do
    it_behaves_like 'requires sign in' do
      let(:action) { get :edit, params: { slug: reading.slug } }
    end

    it_behaves_like 'requires signed in admin' do
      let(:action) { get :edit, params: { slug: reading.slug } }
    end

    context 'with signed in admin' do
      it 'renders the edit template' do
        sign_in(admin)

        get :edit, params: { slug: reading.slug }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH update' do
    it_behaves_like 'requires sign in' do
      let(:action) { patch :update,
        params: {
          slug: reading.slug,
          water_meter_reading: {
            reading: 100
          }
        }
      }
    end

    it_behaves_like 'requires signed in admin' do
      let(:action) { patch :update,
        params: {
          slug: reading.slug,
          water_meter_reading: {
            reading: 100
          }
        }
      }
    end

    context 'with logged in admin and invalid params' do
      before do
        sign_in(admin)

        patch :update,
          params: {
            slug: reading.slug,
            water_meter_reading: {
              reading: ''
            }
          }
      end

      it 'sets the flash error message' do
        expect(flash[:error]).to be_present
      end

      it 'does not update the reading' do
        expect(WaterMeterReading.find_by(slug: reading.slug).reading).to eq(1)
      end

      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  context 'with logged in admin and valid params' do
    before do
      sign_in(admin)

      patch :update,
        params: {
          slug: reading.slug,
          water_meter_reading: {
            reading: 300
          }
        }
    end

    it 'sets the flash success message' do
      expect(flash[:success]).to be_present
    end

    it 'updates the record' do
      expect(WaterMeterReading.find_by(slug: reading.slug).reading).to eq(300)
    end

    it 'redirects to the water meter reading show path' do
      expect(response).to redirect_to(water_meter_reading_path(reading))
    end
  end

  describe 'DELETE destroy' do
    it_behaves_like 'requires sign in' do
      let(:action) {
        delete :destroy, params: { slug: reading.slug }
      }
    end

    it_behaves_like 'requires signed in admin' do
      let(:action) {
        delete :destroy, params: { slug: reading.slug }
      }
    end

    context 'with signed in admin and an existing record' do
      before do
        sign_in(admin)

        delete :destroy, params: { slug: reading.slug }
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'deletes the water meter reading' do
        expect(WaterMeterReading.find_by(slug: reading.slug)).to eq(nil)
      end

      it 'redirects to the water meter index path' do
        expect(response).to redirect_to(water_meter_readings_path)
      end
    end

    context 'with signed in admin and a non existing record' do
      before do
        sign_in(admin)
        delete :destroy, params: { slug: 30 }
      end

      it 'sets the flash error message' do
        expect(flash[:error]).to be_present
      end

      it 'redirects to the water meter reading index page' do
        expect(response).to redirect_to(water_meter_readings_path)
      end
    end
  end

  describe 'GET new' do
    it_behaves_like 'requires sign in' do
      let(:action) {
        get :new
      }
    end
  end

  describe 'POST create' do
    let(:user) { create(:user) }

    it_behaves_like 'requires sign in' do
      let(:action) {
        get :new
      }
    end
  end
end

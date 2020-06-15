require 'rails_helper'

RSpec.describe DeactivationsController do
  let(:active_user) { create(:user) }
  let(:suspended_user) { create(:user, suspended: false) }
  let(:admin) { create(:user, admin: true) }

  describe 'POST create' do
    it_behaves_like 'requires sign in' do
      let(:action) { post :create, params: { slug: active_user.slug }  }
    end

    it_behaves_like 'requires signed in admin' do
      let(:action) { post :create, params: { slug: active_user.slug } }
    end

    context 'with signed in admin' do
      context 'with a non suspened user' do
        before do
          sign_in(admin)
          post :create, params: { slug: active_user.slug }
        end

        it 'sets the flash success message' do
          expect(flash[:success]).to be_present
        end

        it 'redirects to the user path' do
          expect(response).to redirect_to(accounts_path)
        end

        it 'changes the users suspened attribute to true' do
          expect(User.find_by(slug: active_user.slug).suspended).to eq(true)
        end
      end

      context 'with a non existent user' do
        before do
          sign_in(admin)
          post :create, params: { slug: 'abc' }
        end

        it 'sets the flash error message' do
          expect(flash[:error]).to be_present
        end

        it 'redirects to the accounts path' do
          expect(response).to redirect_to(accounts_path)
        end
      end
    end

    describe 'DELETE destroy' do
      it_behaves_like 'requires sign in' do
        let(:action) { delete :destroy, params: { slug: active_user.slug }  }
      end

      it_behaves_like 'requires signed in admin' do
        let(:action) { delete :destroy, params: { slug: active_user.slug } }
      end
    end

    context 'with signed in admin' do
      context 'with a non suspened user' do
        before do
          sign_in(admin)
          delete :destroy, params: { slug: active_user.slug }
        end

        it 'sets the flash success message' do
          expect(flash[:success]).to be_present
        end

        it 'redirects to the user path' do
          expect(response).to redirect_to(accounts_path)
        end

        it 'changes the users suspened attribute to false' do
          expect(User.find_by(slug: active_user.slug).suspended).to eq(false)
        end
      end

      context 'with a non existent user' do
        before do
          sign_in(admin)
          delete :destroy, params: { slug: 'abc' }
        end

        it 'sets the flash error message' do
          expect(flash[:error]).to be_present
        end

        it 'redirects to the accounts path' do
          expect(response).to redirect_to(accounts_path)
        end
      end
    end
  end

  describe 'POST deactive_own' do
    it_behaves_like 'requires sign in' do
      let(:action) { delete :destroy, params: { slug: active_user.slug }  }
    end

    context 'with signed in user' do
      before do
        sign_in(active_user)
        post :deactivate_own
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end

      it 'changes the users suspended attribute to true' do
        expect(User.find(active_user.id).suspended).to eq(true)
      end
    end
  end
end

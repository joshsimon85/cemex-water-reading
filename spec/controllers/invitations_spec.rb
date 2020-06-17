require 'rails_helper'

RSpec.describe InvitationsController do
  let(:admin) { create(:user, admin: true) }
  let(:invite) { create(:invitation, user_id: admin.id) }

  describe 'GET index' do
    it_behaves_like 'requires signed in admin' do
      let(:action) { get :index }
    end

    it_behaves_like 'requires sign in' do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    it_behaves_like 'requires signed in admin' do
      let(:action) { post :create,
        params: {
          invitation: {
            email: 'test@test.com', admin: false
          }
        }
      }
    end

    it_behaves_like 'requires sign in' do
      let(:action) { post :create,
        params: {
          invitation: {
            email: 'test@test.com', admin: false
          }
        }
      }
    end

    context 'with signed in admin and valid invite' do
      before do
        sign_in(admin)
        post :create, params: {
          invitation: {
            email: 'test@test.com',
            admin: false
          }
        }
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the invitations path' do
        expect(response).to redirect_to(invitations_path)
      end

      it 'creates the invitation' do
        expect(Invitation.count).to eq(1)
      end

      it 'sends out an invitations email' do
        expect(ActionMailer::Base.deliveries.last).to be_present
      end

      it 'send the email to the email defined in the invitation' do
        expect(ActionMailer::Base.deliveries.last.to).to eq(['test@test.com'])
      end

      it 'sends an email with the the token' do
        expect(ActionMailer::Base.deliveries.last.body.encoded).to include("?token=#{Invitation.first.token}")
      end

      it 'creates an audit' do
        expect(Audit.count).to eq(1)
      end
    end

    context 'with signed in admin and invalid invite' do
      before do
        sign_in(admin)
        post :create, params: {
          invitation: {
            email: '',
            admin: false
          }
        }
      end

      it 'sets the flash error message' do
        expect(flash[:error]).to be_present
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'does not creates the invitation' do
        expect(Invitation.count).to eq(0)
      end
    end

    context 'with signed in admin and invite for a user that exists' do
      before do
        sign_in(admin)
        post :create, params: {
          invitation: {
            email: admin.email,
            admin: false
          }
        }
      end

      it 'sets a flash error message' do
        expect(flash[:error]).to be_present
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'does not create the invitation' do
        expect(Invitation.find_by(email: admin.email)).to eq(nil)
      end
    end
  end

  describe "DELETE destroy" do
    it_behaves_like 'requires signed in admin' do
      let(:action) { delete :destroy, params: { id: invite.id } }
    end

    it_behaves_like 'requires sign in' do
      let(:action) { delete :destroy, params: { id: invite.id } }
    end

    context 'with signed in admin' do
      before do
        sign_in(admin)
        delete :destroy, params: { id: invite.id }
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the invitations index page' do
        expect(response).to redirect_to(invitations_path)
      end

      it 'deletes the invitation' do
        expect(Invitation.where(id: invite.id)).to eq([])
      end

      it 'creates an audit' do
        expect(Audit.count).to eq(1)
      end
    end
  end
end

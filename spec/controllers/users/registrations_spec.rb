require 'rails_helper'
require 'devise'

RSpec.describe Users::RegistrationsController do
  let(:admin) { create(:user, admin: true) }
  let(:invite) { create(:invitation, user_id: admin.id) }

  def setup
   @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'GET new' do
    context 'with a valid invitation' do
      it 'should allow access to the new template' do
        get :new, params: { token: invite.token }
        expect(response).to render_template(:new)
      end
    end
  end
end

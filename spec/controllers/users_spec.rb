require 'rails_helper'

RSpec.describe UsersController do
  it_behaves_like 'requires signed in admin' do
    let(:action) { get :index }
  end

  it_behaves_like 'requires sign in' do
    let(:action) { get :index }
  end
end

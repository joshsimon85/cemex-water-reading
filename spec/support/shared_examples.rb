shared_examples 'requires signed in admin' do
  it 'redirects to the root path' do
    admin = create(:user, admin: true)

    sign_in(admin)
    action
    expect(response).to redirect_to root_path
    expect(flash[:alert]).to be_present
  end
end

shared_examples 'requires sign in' do
  it 'redirects to the sign in page' do
    action
    expect(response).to redirect_to sign_in_path
    expect(flash[:alert]).to be_present
  end
end

shared_examples 'requires signed in admin' do
  it 'redirects new water meter reading path' do
    user = create(:user, admin: false)

    sign_in(user)
    action
    expect(response).to redirect_to(new_water_meter_reading_path)
    expect(flash[:error]).to be_present
  end
end

shared_examples 'requires sign in' do
  it 'redirects to the sign in page' do
    action
    expect(response).to redirect_to new_user_session_path
    expect(flash[:alert]).to be_present
  end
end

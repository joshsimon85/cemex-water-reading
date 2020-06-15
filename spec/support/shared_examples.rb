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
  context 'without a sign in' do
    it 'redirects to the sign in page' do
      action
      expect(response).to redirect_to new_user_session_path
      expect(flash[:alert]).to be_present
    end
  end
  context 'with a signed in user who is suspened' do
    before do
      user = create(:user, admin: true, suspended: false)
      sign_in(user)
      user.update(suspended: true)
      action
    end

    it 'sets the flash error message' do
      expect(flash[:error]).to be_present
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to(root_path)
    end
  end
end

require 'rails_helper'

describe 'User sign in process' do
  let(:jon) { create(:user, password: 'password', admin: true, suspended: true) }
  let(:jane) { create(:user, password: 'password', suspended: false) }

  scenario 'logging in when the users account is suspended', :js => true do
    visit root_path

    fill_in 'Email', with: jon.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_selector('.alert-danger')
    expect(page).to have_content('Sorry that account has been suspended.')
    expect(page).to have_content('Sign In')
  end

  scenario 'logging in with an existing account that is not suspended' do
    visit root_path

    fill_in 'Email', with: jane.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_selector('.alert-success')
    expect(page).to have_content('Signed in successfully.')
  end
end

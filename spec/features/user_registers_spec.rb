require 'rails_helper'

describe 'User registrations process' do
  let(:jon) { create(:user, password: 'password', admin: true) }
  let(:invite) { create(:invitation, user_id: jon.id) }

  scenario 'registering with out a token', :js => true do
    visit new_user_registration_path

    expect(page).to have_selector('.alert-danger')
    expect(page).to have_content("Sorry, you don't have permission")
    expect(page).to have_content('Sign In')
  end

  scenario 'registering with out a token', :js => true do
    visit "sign_up?token=#{invite.token}"

    expect(find_field('Email').value).to eq("#{invite.email}")
    expect(page).to have_content('Sign Up')

    click_button 'Sign up'

    expect(page).to have_selector('.alert-danger')
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Full name can't be blank")

    fill_in 'Full name', with: 'Jane Doe'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_selector('.alert-success')
    expect(page).to have_content('A message with a confirmation link has been sent to your email address')
    expect(page).to have_content('Sign In')
  end
end

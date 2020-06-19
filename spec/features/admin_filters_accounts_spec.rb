require 'rails_helper'

describe 'Admin accounts filtering process' do
  let(:jon)        { create(:user, password: 'password', admin: true) }
  let!(:user_1)    { create(:user) }
  let!(:user_2)    { create(:user) }

  before do
    visit new_user_session_path

    fill_in 'Email', :with => jon.email
    fill_in 'Password', :with => jon.password

    click_button 'Sign in'
  end

  scenario 'with valid full name' do
    visit accounts_path

    fill_in 'search', with: user_1.full_name
    click_button 'Search'

    within 'tbody' do
      expect(page).to have_selector('tr', count: 1)
      expect(page).to have_content(user_1.email)
    end
  end

  scenario 'with valid email' do
    visit accounts_path

    fill_in 'search', with: user_1.email
    click_button 'Search'

    within 'tbody' do
      expect(page).to have_selector('tr', count: 1)
      expect(page).to have_content(user_1.email)
    end
  end

  scenario 'with partial name case insensitive' do
    visit accounts_path

    fill_in 'search', with: user_2.full_name.upcase[0..2]
    click_button 'Search'

    within 'tbody' do
      expect(page).to have_selector('tr', count: 1)
      expect(page).to have_content(user_2.email)
    end
  end

  scenario 'with invalid email' do
    visit accounts_path

    fill_in 'search', with: user_2.email + 'z'
    click_button 'Search'

    expect(page).to have_content('Sorry, there are no accounts to show!')
  end
end

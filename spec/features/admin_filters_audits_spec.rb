require 'rails_helper'

describe 'Admin accounts filtering process' do
  let(:jon)         { create(:user, password: 'password', admin: true) }
  let(:date)        { Date.today }
  let!(:audit_1)    { create(:audit) }
  let!(:audit_2)    { create(:audit) }

  before do
    visit new_user_session_path

    fill_in 'Email', :with => jon.email
    fill_in 'Password', :with => jon.password

    click_button 'Sign in'
  end

  scenario 'admin uses filter by date with todays date' do
    visit audit_history_path

    fill_in 'search_created', with: (Date.today.strftime('%m-%d-%Y'))

    click_button('Filter')

    within('tbody') do
      expect(page).to have_selector('tr', count: 2)
      # ensure the dates are the ones selected
      expect(page).to have_content(date.strftime('%A, %B %d, %Y'))
    end
  end

  scenario 'admin uses filter by date with date a month ago' do
    visit audit_history_path

    fill_in 'search_created', with: ((Date.today - 1.month).strftime('%m-%d-%Y'))

    click_button('Filter')

    expect(page).to have_content('Sorry, there are no audits to show!')
  end
end

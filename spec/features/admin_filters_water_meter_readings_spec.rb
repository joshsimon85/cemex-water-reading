require 'rails_helper'

describe 'Admin water meter reading filtering process' do
  let(:jon)        { create(:user, password: 'password', admin: true) }
  let(:date)       { Date.today }
  let!(:reading_1) { create(:water_meter_reading, :with_image, user_id: jon.id) }
  let!(:reading_2) { create(:water_meter_reading, :with_image, user_id: jon.id) }
  let!(:reading_3) { create(:water_meter_reading,
                           :with_image,
                           user_id: jon.id,
                           created_at: Date.today + 1.month) }


  before do
    visit new_user_session_path
    fill_in 'Email', :with => jon.email
    fill_in 'Password', :with => jon.password

    click_button 'Sign in'
  end

  scenario 'admin uses filter by month with todays date', :js => true do
    visit water_meter_readings_path

    select date.year, from: 'readings_created on_1i'
    select date.strftime("%B"), from: 'readings_created on_2i'

    within('section:first-of-type') do
      click_button('Filter')
    end

    # ensure there are two elements found and located in the tables body
    within('tbody') do
      expect(page).to have_selector('tr', count: 2)
      # ensure the dates are the ones selected
      expect(page).to have_content(date.strftime('%A, %B %d, %Y'))
    end
  end

  scenario 'admin uses filter by month with next months date', :js => true do
    visit water_meter_readings_path

    select date.year, from: 'readings_created on_1i'
    select (date + 1.month).strftime("%B"), from: 'readings_created on_2i'

    within('section:first-of-type') do
      click_button('Filter')
    end

    within('tbody') do
      expect(page).to have_selector('tr', count: 1)
      # ensure the dates are the ones selected
      expect(page).to have_content((date + 1.month).strftime('%A, %B %d, %Y'))
    end
  end

  scenario 'admin uses filter by month with last months date', :js => true do
    visit water_meter_readings_path

    select date.year, from: 'readings_created on_1i'
    select (date - 1.month).strftime("%B"), from: 'readings_created on_2i'

    within('section:first-of-type') do
      click_button('Filter')
    end

    expect(page).to have_content 'Sorry, there are no readings to show!'
  end

  scenario 'admin uses filter by date with todays date' do
    visit water_meter_readings_path

    fill_in 'reading_created on', with: (Date.today.strftime('%m-%d-%Y'))

    within('section:nth-of-type(2)') do
      click_button('Filter')
    end

    within('tbody') do
      expect(page).to have_selector('tr', count: 2)
      # ensure the dates are the ones selected
      expect(page).to have_content(date.strftime('%A, %B %d, %Y'))
    end
  end

  scenario 'admin uses filter by date with 1 month from todays date' do
    visit water_meter_readings_path

    fill_in 'reading_created on', with: (Date.today + 1.month).strftime('%m-%d-%Y')

    within('section:nth-of-type(2)') do
      click_button('Filter')
    end

    within('tbody') do
      expect(page).to have_selector('tr', count: 1)
      # ensure the dates are the ones selected
      expect(page).to have_content((date + 1.month).strftime('%A, %B %d, %Y'))
    end
  end

  scenario 'admin uses filter by date with 1 month previous from todays date' do
    visit water_meter_readings_path

    fill_in 'reading_created on', with: (Date.today - 1.month).strftime('%m-%d-%Y')

    within('section:nth-of-type(2)') do
      click_button('Filter')
    end

    expect(page).to have_content 'Sorry, there are no readings to show!'
  end
end

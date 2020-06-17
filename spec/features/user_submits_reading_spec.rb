require 'rails_helper'

describe 'User submits a reading' do
  let(:jon) { create(:user, password: 'password') }


  scenario 'signed in user with invalid reading', :js => true do
    visit root_path

    fill_in 'Email', with: jon.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    visit new_water_meter_reading_path

    find('#water_meter_reading_image', visible: false).set("#{Rails.root}/spec/support/assets/test_image.jpeg")

    click_button 'Submit'

    expect(page).to have_selector('.alert-danger')
    expect(page).to have_content('The following 2 errors prevented')
  end

  scenario 'signed in user with invalid negative reading', :js => true do
    visit root_path

    fill_in 'Email', with: jon.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    visit new_water_meter_reading_path

    find('#water_meter_reading_image', visible: false).set("#{Rails.root}/spec/support/assets/test_image.jpeg")
    find('#water_meter_reading_reading', visible: false).set('-123')

    click_button 'Submit'

    expect(page).to have_selector('.alert-danger')
    expect(page).to have_content('The following 1 error prevented')
    expect(page).to have_content('Reading must be greater than or equal to 0')
  end

  scenario 'signed in user with valid reading', :js => true do
    visit root_path

    fill_in 'Email', with: jon.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    visit new_water_meter_reading_path

    find('#water_meter_reading_image', visible: false).set("#{Rails.root}/spec/support/assets/test_image.jpeg")

    find('#water_meter_reading_reading', visible: false).set('123')

    find("input[name='commit']", visible: false).click

    expect(page).to have_selector('.alert-success')
    expect(WaterMeterReading.last).to be_present
    expect(WaterMeterReading.last.reading).to eq(123)
  end
end

require 'rails_helper'

feature 'New user writes their first tweet' do
  scenario "Sign up a new user with valid data" do
    visit new_user_registration_path
    within ("#new_user") do
      fill_in 'Email', with: 'email@email.com'
      fill_in 'Handle', with: 'tweeter'
      fill_in 'Password', with: 'password'
      fill_in "Password confirmation", with: 'password'
    end

    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'


    fill_in "tweet[content]", with: 'first tweet!'
    click_button "Tweet++"
    expect(page).to have_css('.tweet-table-content')
  end
end

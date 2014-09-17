require 'rails_helper'

feature 'Sign In' do
  background do
    User.create(email: 'email@email.com', password: 'password', handle: 'tweeter')
  end

  scenario "Sign in with correct credentials" do
    visit new_user_session_path
    within ("#new_user") do
      fill_in 'Email', with: 'email@email.com'
      fill_in 'Password', with: 'password'
    end

    click_button 'Log in'
    expect(page).to have_content '@tweeter'
  end

  scenario "Sign in w/invalid email/password" do
    visit new_user_session_path
    within("#new_user") do
      fill_in 'Email', with: 'email2@nowhere.com'
      fill_in 'Password', with: 'bruteforceattack!!'
    end

    click_button 'Log in'
    expect(page).to have_content "Invalid email address or password"
  end

end

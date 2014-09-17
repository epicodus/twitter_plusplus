require 'rails_helper'

feature 'Sign Up' do
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
  end

  scenario "Sign up with wrong password confirmation" do
    visit new_user_registration_path
    within ("#new_user") do
      fill_in 'Email', with: 'email@email.com'
      fill_in 'Handle', with: 'tweeter'
      fill_in 'Password', with: 'password'
      fill_in "Password confirmation", with: 'password2'
    end

    click_button 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match Password"
  end


  scenario "Fail to create an account when handle is invalid" do
    visit new_user_registration_path
    within ("#new_user") do
      fill_in 'Email', with: 'email@email.com'
      fill_in 'Handle', with: 'hi'
      fill_in 'Password', with: 'password'
      fill_in "Password confirmation", with: 'password'
    end

    click_button 'Sign up'
    expect(page).to have_content "Handle is too short"
  end

  scenario "Do not create an account if email/handle already exist" do
    user = User.create(email: "email@email.com", handle: "tweeter",
                        password: "password")

    visit new_user_registration_path
    within ("#new_user") do
      fill_in 'Email', with: 'email@email.com'
      fill_in 'Handle', with: 'tweeter'
      fill_in 'Password', with: 'password'
      fill_in "Password confirmation", with: 'password'
    end

    click_button 'Sign up'
    expect(page).to have_content "Email has already been taken"
    expect(page).to have_content "Handle has already been taken"
  end

end

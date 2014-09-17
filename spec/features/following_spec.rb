require 'rails_helper'

feature 'follow user from homepage' do
  background do
    @user1 = User.create(email: 'email@email.com', password: 'password', handle: 'tweeter')
    @user2 = User.create(email: 'test@test.com', password: 'password', handle: 'tweeter2')
  end

  scenario "Sign in and follow suggested user" do
    visit new_user_session_path
    within ("#new_user") do
      fill_in 'Email', with: 'email@email.com'
      fill_in 'Password', with: 'password'
    end

    click_button 'Log in'
    expect(page).to have_content '@tweeter'

    click_link('follow @tweeter2')
    expect(find('#user-followed-users-count')).to have_content '1'
  end
end

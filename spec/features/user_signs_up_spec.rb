require 'rails_helper'

feature "a user signs up", %q(

As a prospective user,
I want to create an account,
So that I can post books and review them

Acceptance Criteria
[x] There is a link to 'Sign Up' on the homepage.
[x] If I fill in my first name, last name, email, password, and password confirmation, I am greeted with a confirmation message that my account has been created.
[ ] If the password and password confirmation fields do not match, I am given an error message.
[ ] If my email already exists in the database, I am given a message that tells me I have already resgistered.
[ ] If my email is not formatted correctly, I am given an error message.

) do

  scenario "user provides valid information" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Avon"
    fill_in "Last name", with: "Barksdale"
    fill_in "Email", with: "avon.barksdale@thewire.com"
    fill_in "Password", with: "westside4life"
    fill_in "Password confirmation", with: "westside4life"
    click_button "Sign Up"

    expect(page).to have_content "Your account has been succesfully created."
    expect(page).to_not have_link "Sign Up"
    expect(page).to have_link "Sign Out"

  end

end

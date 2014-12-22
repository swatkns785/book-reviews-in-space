require 'rails_helper'

feature "a user signs up", %q(

As a prospective user,
I want to create an account,
So that I can post books and review them

Acceptance Criteria
[x] There is a link to 'Sign Up' on the homepage.
[x] If I fill in my first name, last name, email, password, and password confirmation, I am greeted with a confirmation message that my account has been created.
[x] If the password and password confirmation fields do not match, I am given an error message.
[x] If my email already exists in the database, I am given a message that tells me I have already resgistered.
[ ] If my email is not formatted correctly, I am given an error message.

) do

  context 'Perfect sign up process' do

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

  context 'Problems when signing in' do

    scenario 'password and password confirmation do not match' do
      visit root_path
      click_on "Sign Up"
      fill_in "First name", with: "Jimmy"
      fill_in "Last name", with: "McNulty"
      fill_in "Email", with: "jimmy.mcnulty@thewire.com"
      fill_in "Password", with: "itaintmyturn"
      fill_in "Password confirmation", with: "itaintyourturn"
      click_button "Sign Up"

      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    scenario 'User already exists in database' do

      existing_user = User.create(first_name: "Bunk", last_name: "Moreland", email: "daaabuuuuunk@bpd.com", password: "suitsandties")

      visit root_path
      click_on "Sign Up"
      fill_in "First name", with: existing_user.first_name
      fill_in "Last name", with: existing_user.last_name
      fill_in "Email", with: existing_user.email
      fill_in "Password", with: existing_user.password
      fill_in "Password confirmation", with: existing_user.password
      click_button "Sign Up"

      expect(page).to have_content "This email address has already been registered."

    end

    scenario 'Email not formatted correctly' do
      visit root_path
      click_on "Sign Up"
      fill_in "First name", with: "Beadie"
      fill_in "Last name", with: "Russell"
      fill_in "Email", with: "beatrice.russell.com"
      fill_in "Password", with: "beadiemcnulty"
      fill_in "Password confirmation", with: "beadiemcnulty"
      click_button "Sign Up"

      expect(page).to have_content "Email is invalid"

    end

  end

end

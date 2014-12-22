require 'rails_helper'

feature "authenticated user deletes account", %q(

As an authenticated user
I want to delete my account
So that my information is no longer retained by the app

Acceptance Criteria
[x] User sees form with existing information.
[x] Upon deleting account, user sees message saying account succesfully deleted.
[x] User tries to login with prior credentials and is told account no longer exists.

) do

  context "user sucessfully deletes account" do

    scenario "user successfully deletes account" do
      dummy_user = User.create(first_name: "Marlo", last_name: "Stanfield", email: "marlo.stanfield@packages.com", password: "mynameismyname")

      visit root_path
      click_on "Sign In"
      fill_in "Email", with: dummy_user.email
      fill_in "Password", with: dummy_user.password
      click_button "Log in"

      expect(page).to have_content "Edit Account"

      click_link "Edit Account"

      expect(page).to have_selector("input[value='marlo.stanfield@packages.com']")

      click_on "Cancel my account"

      expect(page).to have_content "Bye! Your account has been successfully cancelled. We hope to see you again soon."
      expect(page).to have_content "Sign In"

      click_on "Sign In"

      fill_in "Email", with: dummy_user.email
      fill_in "Password", with: dummy_user.password
      click_button "Log in"

      expect(page).to have_content "Invalid email or password."
    end

  end

end

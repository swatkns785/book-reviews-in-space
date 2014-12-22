require 'rails_helper'

feature "authenticated user view profile page and edits information", %q(

As an authenticated user
I want to see my profile page
So that I can change information on it

Acceptance Criteria
[x] User changes password and is able to log in with new password, sees confirmation messages.
[x] User logs in with new password and it is successful.
[ ] User tries to log in with old password and sees invalid password message.

) do

  context "successful attempt at changing password" do

    scenario "user successfully changes password" do
      existing_user = User.create(
        first_name: "Bunk",
        last_name: "Moreland",
        email: "daaabuuuuunk@bpd.com",
        password: "suitsandties"
      )

      new_password = "warsend1234"

      visit root_path
      expect(page).to have_content "Sign In"
      click_on "Sign In"

      fill_in "Email", with: existing_user.email
      fill_in "Password", with: existing_user.password
      click_button "Log in"

      expect(page).to have_content "Edit Account"

      click_link "Edit Account"
      expect(page).to have_selector("input[value='daaabuuuuunk@bpd.com']")
      fill_in "Password", with: new_password
      fill_in "Password confirmation", with: new_password
      fill_in "Current password", with: existing_user.password
      click_button "Update"

      expect(page).to have_content "Your account has been updated successfully."
      click_on "Sign Out"

      expect(page).to have_content "Signed out successfully."
      click_on "Sign In"

      fill_in "Email", with: existing_user.email
      fill_in "Password", with: new_password
      click_button "Log in"

      expect(page).to have_content "Signed in successfully."

    end

  end

  context "user tries to log in with wrong credentials" do

    scenario "user tries to log in with old password" do
      existing_user = User.create(
      first_name: "Bunk",
      last_name: "Moreland",
      email: "daaabuuuuunk@bpd.com",
      password: "suitsandties"
      )

      old_password = "suitsandties"
      new_password = "warsend1234"

      visit root_path
      expect(page).to have_content "Sign In"
      click_on "Sign In"

      fill_in "Email", with: existing_user.email
      fill_in "Password", with: existing_user.password
      click_button "Log in"

      expect(page).to have_content "Edit Account"

      click_link "Edit Account"
      expect(page).to have_selector("input[value='daaabuuuuunk@bpd.com']")
      fill_in "Password", with: new_password
      fill_in "Password confirmation", with: new_password
      fill_in "Current password", with: existing_user.password
      click_button "Update"

      expect(page).to have_content "Your account has been updated successfully."
      click_on "Sign Out"

      expect(page).to have_content "Signed out successfully."
      click_on "Sign In"

      fill_in "Email", with: existing_user.email
      fill_in "Password", with: old_password
      click_button "Log in"

      expect(page).to have_content "Invalid email or password."
    end

  end

end

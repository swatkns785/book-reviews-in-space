require "rails_helper"

feature "user edits a book review", %q(

As a user
I want to edit a review
So that I can correct any mistakes or add updates

Acceptance Criteria

[ ] I must provide valid information
[ ] I must be presented with errors if I fill out the form incorrectly
[x] I must be able to get to the edit page from the book details page

) do

  context "user successfully updates review" do

    scenario "user successfully updates review" do

      visit root_path
      click_link "Sign In"
      fill_in "Email", with: "chuckie@cheese.com"
      fill_in "Password", with: "cheeseisgood"
      click_button "Log in"

      expect(page).to have_content "The man on the moon"
      click_link "The man on the moon"

      expect(page).to have_content "The rain in Spain can cause no pain if the brain is fed with nutritious grain."
      expect(page).to have_content "Edit Review"

      click_on "Edit Review"
      expect(page).to have_content "Description"
      fill_in "Description", with: "456789123 The rain in Spain can cause no pain if the brain is fed with nutritious grain."
      click_button "Update Review"

      expect(page).to have_content "Your review has been successfully updated."
      expect(page).to have_content "456789123 The rain in Spain can cause no pain if the brain is fed with nutritious grain."

    end

  end

end

require "rails_helper"

feature "user edits a book review", %q(

As a user
I want to edit a review
So that I can correct any mistakes or add updates

Acceptance Criteria

[x] I must provide valid information
[x] I must be presented with errors if I fill out the form incorrectly
[x] I must be able to get to the edit page from the book details page

) do

  def create_user_and_sign_in
    user = FactoryGirl.create(:user)

    visit root_path
    click_on "Sign In"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content "Signed in successfully."
    expect(page).to have_content "Post a Book"

  end

  def create_book
    FactoryGirl.create(:book)
  end



  context "user successfully updates review" do

    scenario "user successfully updates review" do

      user = create_user_and_sign_in
      book = create_book

      visit root_path

      expect(page).to have_content book.title
      click_link book.title

      expect(page).to have_content book.title
      expect(page).to have_content book.description

      fill_in "Description", with: "Mice are friggin awesome, a lot cooler than men 1234."
      click_button "Submit Review"
      expect(page).to have_content "Review successfully submitted."

      expect(page).to have_content "Edit Review"
      click_on "Edit Review"

      expect(page).to have_content
      expect(page).to have_content "Mice are friggin awesome, a lot cooler than men 1234."
      fill_in "Description", with: "The rain in Spain can cause no pain if the brain is fed with nutritious grain."
      click_button "Update Review"

      expect(page).to have_content "Your review has been successfully updated."
      expect(page).to have_content "The rain in Spain can cause no pain if the brain is fed with nutritious grain."

    end

  end

  context "user is unsuccessful in updating the review" do

    scenario "user does not enter enough characters" do

      user = create_user_and_sign_in
      book = create_book

      visit root_path

      expect(page).to have_content book.title
      click_link book.title

      expect(page).to have_content book.title
      expect(page).to have_content book.description

      fill_in "Description", with: "Mice are friggin awesome, a lot cooler than men 1234."
      click_button "Submit Review"
      expect(page).to have_content "Review successfully submitted."

      expect(page).to have_content "Edit Review"
      click_on "Edit Review"

      expect(page).to have_content
      expect(page).to have_content "Mice are friggin awesome, a lot cooler than men 1234."
      fill_in "Description", with: "This description is too short."
      click_button "Update Review"

      expect(page).to have_content "Minimum of 50 characters required."

    end

  end

end

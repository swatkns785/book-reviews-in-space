require "rails_helper"

feature "user deletes a book review", %q(

As a user
I want to delete a review
So that I can delete my review if I no longer want to show it

Acceptance Criteria

[ ] I must be able delete a review from the review edit page
[ ] I must be able delete a review from the review details page

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

  scenario "user successfully deletes a review" do

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

    expect(page).to have_content "Mice are friggin awesome, a lot cooler than men 1234."
    click_button "Delete this review"

    expect(page).to have_content "Your review has been successfully deleted."
    expect(page).to_not have_content "Mice are friggin awesome, a lot cooler than men 1234."

  end

end

require "rails_helper"

feature "user reviews a book", %q(

As a user
I want to review a book
So I can let other users know what I thought about it

Acceptance Criteria

[x] I must be on the book detail page
[x] I must provide a description that is at least 50 characters long
[x] I must be presented with errors if I fill out the form incorrectly

) do

  def create_user_and_sign_in_and_click_post_a_book
    user = FactoryGirl.create(:user)

    visit root_path
    click_on "Sign In"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content "Signed in successfully."
    expect(page).to have_content "Post a Book"

    click_link "Post a Book"
  end

  def create_book
    FactoryGirl.create(:book)
  end

  context "user successfully creates a book review" do

    scenario "create a book review" do

      create_user_and_sign_in_and_click_post_a_book
      book = create_book

      visit root_path
      expect(page).to have_link book.title

      click_link book.title

      expect(page).to have_content "Fill out the form below to leave a review"

      fill_in "Description:", with: "A book about men and mice playing dice it's niiice."
      click_button "Submit Review"

      expect(page).to have_content "Review successfully submitted."

    end

  end

  context "user makes mistakes" do

     scenario "user enters a description that is too short" do

       create_user_and_sign_in_and_click_post_a_book
       book = create_book

       visit root_path
       expect(page).to have_link book.title

       click_link book.title

       expect(page).to have_content "Fill out the form below to leave a review"

       fill_in "Description:", with: "This description is too short"
       click_button "Submit Review"

       expect(page).to have_content "This description is too short. 50 character minimum."

     end

   end

end

require "rails_helper"

feature "user views book's reviews", %q(

As a user
I want to view the reviews for a book
So that I can see what people are saying about it

Acceptance Criteria

[ ] I must be on the book detail page
[ ] I must only see reviews to books I'm viewing
[ ] I must see all reviews listed in order, most recent first
[ ] I must see if the writer of the review is a candidate or an astronaut

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
    FactoryGirl.create(:review)
  end

  def create_review
    FactoryGirl.create(:review)
  end

  scenario "a user views a book's reviews" do

    create_user_and_sign_in_and_click_post_a_book

    book1 = FactoryGirl.create(:book)
    review1 = FactoryGirl.create(:review, book_id: book1.id)
    review12 = FactoryGirl.create(:review, book_id: book1.id)

    book2 = FactoryGirl.create(:book)

    visit root_path

    click_link book1.title

    review1_location = page.body.index(review1.description)
    review12_location = page.body.index(review12.description)

    expect(page).to have_content "Check out some reviews for #{book1.title} below."
    expect(page).to have_content review1.description
    expect(page).to have_content review12.description
    expect(page).to have_content "Reviewed by: Marlo Stanfield, a Candidate."

    expect(review12_location).to be < review1_location

    click_link "Back to homepage"

    click_link book2.title

    expect(page).to_not have_content "Reviewed by: Marlo Stanfield, a Candidate."

  end

end

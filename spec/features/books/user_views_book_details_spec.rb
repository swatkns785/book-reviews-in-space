require "rails_helper"

feature "user views a book's details", %q(

As a user
I want to view a book's details
So that I can see a book's details

Acceptance Criteria

[x] I must be able to get to this page from the books index
[x] I must see the book's title
[x] I must see the book's description
[x] I must see the book's URL

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

  scenario "user views a book's details" do

    first_book = FactoryGirl.create(:book)
    second_book = FactoryGirl.create(:book)

    create_user_and_sign_in_and_click_post_a_book

    visit root_path

    expect(page).to have_content "All of the books"
    expect(page).to have_content first_book.title

    click_link first_book.title

    expect(page).to have_content first_book.title
    expect(page).to have_content first_book.author
    expect(page).to have_content first_book.description
    expect(page).to have_link first_book.url

    expect(page).to have_content "Back to homepage"

  end

end

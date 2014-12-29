require "rails_helper"

feature "user deletes a book", %q(

As a user
I want to delete a book I posted
So that I can delete a book I posted for any reason

Acceptance Criteria

[ ] I must be able delete a book from the book details page
[ ] All reviews associated with the book must also be deleted

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

  scenario "user deletes a book" do

    user = create_user_and_sign_in
    book = create_book

    visit root_path

    expect(page).to have_content book.title
    click_link book.title

    expect(page).to have_content book.title
    expect(page).to have_content book.description

    click_button "Delete this book"

    expect(page).to_not have_content book.title

  end

end

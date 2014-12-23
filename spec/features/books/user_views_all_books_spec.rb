require "rails_helper"

feature "user posts link to book", %q(

As a user
I want to view recently posted books
So that I can see what others are reading

Acceptance Criteria

[x] I must see the title of each book
[x] I must see the description of each book
[x] I must see the URL of each book
[x] I must see books listed in order, most recently posted first
[x] I must see if a book was posted by an astronaut or a candidate

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


  scenario "a user views all of the books on the homepage, meeting all acceptance criteria" do

    create_user_and_sign_in_and_click_post_a_book

    first_book = FactoryGirl.create(:book)
    second_book = FactoryGirl.create(:book)

    visit root_path

    first_book_location = page.body.index(first_book.title)
    second_book_location = page.body.index(second_book.title)

    expect(page).to have_content "All of the books"
    expect(page).to have_content "Of Mice and Men 1"
    expect(page).to have_content "Of Mice and Men 2"
    expect(page).to have_content "John Steinbeck"
    expect(page).to have_content "A book about mice and men."
    expect(page).to have_content "Candidate"
    expect(page).to have_link "http://www.sparknotes.com/lit/micemen/"
    expect(second_book_location).to be < first_book_location

  end

end

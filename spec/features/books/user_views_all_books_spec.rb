require "rails_helper"

feature "user posts link to book", %q(

As a user
I want to view recently posted books
So that I can see what others are reading

Acceptance Criteria

[ ] I must see the title of each book
[ ] I must see the description of each book
[ ] I must see the URL of each book
[ ] I must see books listed in order, most recently posted first
[ ] I must see if a book was posted by an astronaut or a candidate

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

  scenario "a user views all of the books on the homepage, meeting all acceptance criteria", focus: true do

    create_user_and_sign_in_and_click_post_a_book

    5.times do
      create_book
    end

    visit root_path

    expect(page).to have_content "All of the books"
    expect(page).to have_content "Of Mice and Men 1"
    expect(page).to have_content "Of Mice and Men 2"
    expect(page).to have_content "Of Mice and Men 3"
    expect(page).to have_content "Of Mice and Men 4"
    expect(page).to have_content "Of Mice and Men 5"
    expect(page).to have_content "John Steinbeck"
    expect(page).to have_content "A book about mice and men."
    expect(page).to have_link "http://www.sparknotes.com/lit/micemen/"

  end

end

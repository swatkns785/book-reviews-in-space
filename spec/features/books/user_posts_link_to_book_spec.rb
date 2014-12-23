require "rails_helper"

feature "user posts link to book", %q(

As a user
I want to post a link to a book
So I can share what I'm reading with others

Acceptance Criteria

[ ] I must provide a title that is at least 1 character long
[ ] I must provide a description that is at least 10 characters long
[ ] I must provide a valid URL to the book
[ ] I must be presented with errors if I fill out the form incorrectly

) do

  def create_user_and_sign_in
    user = FactoryGirl.create(:user)

    visit root_path
    click_on "Sign In"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  context "user successfully posts link to a book" do

    scenario "post link to book on page" do
      user = FactoryGirl.create(:user)

      visit root_path
      click_on "Sign In"

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"

      expect(page).to have_content "Signed in successfully."
      expect(page).to have_content "Post a Book"

      click_link "Post a Book"

      fill_in "Title", with: "Of Mice and Men"
      fill_in "Author", with: "John Steinbeck"
      fill_in "Description", with: "A book about mice and men."
      fill_in "URL", with: "http://www.sparknotes.com/lit/micemen/"

      click_button "Submit"

      expect(page).to have_content "Your book has been succesfully added."
      expect(page).to have_content "Of Mice and Men"

    end

  end

  context 'user makes mistakes when posting book' do

    scenario "User leaves title field blank (less than 1 character)" do
      create_user_and_sign_in

      expect(page).to have_content "Signed in successfully."
      expect(page).to have_content "Post a Book"

      click_link "Post a Book"

      fill_in "Title", with: ""
      fill_in "Author", with: "John Steinbeck"
      fill_in "Description", with: "A book about mice and men."
      fill_in "URL", with: "http://www.sparknotes.com/lit/micemen/"

      click_button "Submit"

      expect(page).to have_content "Fill out the forms below to add book to your collection."
      expect(page).to have_content "Title can't be blank"

    end

  end

end

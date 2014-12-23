class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to root_path
       flash[:notice] = "Your book has been succesfully added."
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(
    :title,
    :author,
    :description,
    :url,
    :user_id
    )
  end

end
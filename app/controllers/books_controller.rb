class BooksController < ApplicationController

  def index
    @books = Book.all.order('created_at DESC')
  end

  def show
    @book = Book.find(params[:id])
    @reviews = Review.order('created_at DESC').where book_id: params[:id]
    @review = Review.new
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

  def destroy
    @book = Book.find(params[:id])
    @reviews = Review.where book_id: params[:id]

    @reviews.each do |r|
      r.destroy
    end

    @book.destroy

    flash[:notice] = "Your book has been successfully been destroyed."
    redirect_to root_path
    
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

class ReviewsController < ApplicationController

  def create

    @book_id = params[:book_id]
    @book = Book.find(params[:book_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.book_id = @book_id

    if @review.save
      redirect_to book_path(@book.id)
      flash[:notice] = "Review successfully submitted."
    else
      redirect_to book_path(@book.id)
    end
  end

  def edit
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
  end

  def update
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])

    if @review.update_attributes(review_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "Your review has been successfully updated."
    else
      redirect_to edit_book_review_path(@book, @review)
      flash[:notice] = "Minimum of 50 characters required."
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])

    @review.destroy
    flash[:notice] = "Your review has been succesfully deleted."
    redirect_to book_path(@book)
  end

  private

  def review_params
    params.require(:review).permit(:description, :user_id, :book_id)
  end

end

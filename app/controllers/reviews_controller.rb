class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @book = Book.find(params[:book_id])
  end

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
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:description, :user_id, :book_id)
  end

end

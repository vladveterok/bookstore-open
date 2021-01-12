class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.create(review_params)
    redirect_to book_path(review_params[:book_id]), notice: I18n.t('show.review.created') unless @review.errors.any?
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :score, :book_id, :user_id)
  end
end

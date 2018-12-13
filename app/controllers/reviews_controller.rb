class ReviewsController < ApplicationController

  def get_params
    params.permit(:rating, :reviewer_id, :reviewed_user_id, :comment)
  end

  def create
    permitted = get_params
    @review = Review.create(permitted)
	end
end
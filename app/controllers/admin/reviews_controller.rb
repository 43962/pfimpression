class Admin::ReviewsController < ApplicationController

  def index
    @review = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

   private

  def review_params
    params.require(:review).permit(:name, :height, :weight, :review, :item_name,)
  end

end

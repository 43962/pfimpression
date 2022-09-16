class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!, except: [:top]

  def index
    @reviews = Review.where(is_draft: false).page(params[:page]).per(8)
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
     redirect_to '/reviews'
  end

   private

  def review_params
    params.require(:review).permit(:height, :weight, :review, :item_name,)
  end

end

class Public::ReviewsController < ApplicationController

  def index
   @review = Review.all
   @review = Review.page(params[:page]).per(8)
  end

  def update
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to '/reviews'
  end

  def show
   @review = Review.find(params[:id])
   @comment = Comment.new
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    if @review.save
     redirect_to reviews_path
    else
      render:new
    end
  end

  private

  def review_params
    params.require(:review).permit(:name, :height, :weight, :review, :item_name, :image)
  end

end

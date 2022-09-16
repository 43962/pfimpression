class Public::FavoritesController < ApplicationController

  def create
     @review = Review.find(params[:review_id])
     favorite = current_customer.favorites.new(review_id: @review.id)
     favorite.save
     redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:review_id])
    @review_favorite = Favorite.find_by(customer_id: current_customer.id, review_id: params[:review_id])
    @review_favorite.destroy
    redirect_to review_path(@review)
  end

  def index
    @favorites = Favorite.where(customer_id: @customer.id).all
  end

end

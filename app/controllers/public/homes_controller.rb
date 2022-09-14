class Public::HomesController < ApplicationController
  def top
    @search = Review.where(is_draft: false).ransack(params[:q])
    review = @search.result(distinct: true)
    @review = review.order(created_at: :desc).limit(3)
  end

  def about
  end
end

class Public::HomesController < ApplicationController
  def top
    @review = Review.all.order(created_at: :desc).limit(3)
  end

end

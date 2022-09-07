class Public::CommentsController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    comment = current_customer.comments.new(comment_params)
    comment.review_id = @review.id
    comment.save
    redirect_to review_path(@review)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

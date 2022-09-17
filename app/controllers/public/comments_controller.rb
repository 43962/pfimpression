class Public::CommentsController < ApplicationController
   before_action :authenticate_customer!

  def create
    @review = Review.find(params[:review_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.review_id = @review.id
    if @comment.save
      redirect_to review_path(@review)
    else
      # redirect_back fallback_location: root_path
      # エラーメッセージを表示させたいときはrenderを使う(controller名/action)
      render 'public/reviews/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to '/reviews'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

class Public::CategoriesController < ApplicationController

  def index
     @categories = Category.all
  end

  def show
    # @categories = Category.all
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end

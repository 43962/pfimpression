class Admin::CategoriesController < ApplicationController
 before_action :authenticate_admin!, except: [:top]

  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "カテゴリーを追加しました"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
       flash[:notice] = "カテゴリーを変更しました"
       redirect_to admin_categories_path
    else
       flash[:notice] = "カテゴリー名が空白または重複しています。"
       render "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end

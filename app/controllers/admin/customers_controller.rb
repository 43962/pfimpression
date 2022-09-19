class Admin::CustomersController < ApplicationController
   before_action :authenticate_admin!, except: [:top]

  def index
    @customers = Customer.all.page(params[:page]).per(5)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      flash[:notice] = "退会が完了しました。"
      redirect_to admin_customers_path
    else
      flash[:alret] = "退会に失敗しました。"
    end
  end

  def withdraw
    @customer = Customer.find(params[:customer_id])
    @customer.update(is_deleted: 1)
    redirect_to admin_customers_path
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:review_id)
    @favorite_reviews = Review.find(favorites)

  end

  def customer_params
    params.require(:customer).permit(:name, :email, :password, :is_deleted)
  end
end

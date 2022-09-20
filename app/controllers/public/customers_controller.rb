class Public::CustomersController < ApplicationController
    before_action :authenticate_customer!
    before_action :ensure_guest_user, only: [:edit]
    before_action :ensure_correct_customer, only: [:edit, :update]

   def show
     @customer = Customer.find(params[:id])
     @reviews = @customer.reviews.where(is_draft: false)
     @reviews = @reviews.page(params[:page]).per(2)
   end

   def edit
     @customer = Customer.find(params[:id])
   end

   def update
     @customer = Customer.find(params[:id])
     @customer.update(customer_params)
     redirect_to customer_path(@customer)
   end

   def favorites
     customer = Customer.find(params[:id])
     @favorites = customer.favorites
   end

   def unsubscribe
    @customer = Customer.find(params[:id])
   end

   def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
   end

 private

  def customer_params
    params.require(:customer).permit(:name, :email, :password, :is_deleted)
  end

  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
    redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
    redirect_to customer_path(current_customer), notice: "他のユーザーのプロフィール編集画面へは遷移できません。"
    end
  end

end

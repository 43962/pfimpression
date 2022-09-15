class Public::CustomersController < ApplicationController
    before_action :authenticate_customer!
    before_action :ensure_guest_user, only: [:edit]

   def show
     @customer = Customer.find(params[:id])
     @reviews = @customer.review.where(is_draft: false)
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

  # def destroy
  #   @customer = current_customer
  #   @customer.destroy
  #     flash[:notice] = "退会が完了しました。"
  #     redirect_to root_path
  # end

   def unsubscribe
    @customerr = Customer.find_by(params[:id])
   end

   def withdraw
    @customer = current_customer
    @customer.update(is_valid: true)
    reset_session
    redirect_to root_path

   def create
   end

 private

  def customer_params
    params.require(:customer).permit(:name, :email, :password)
  end

  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
    redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end

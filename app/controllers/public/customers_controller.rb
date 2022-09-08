class Public::CustomersController < ApplicationController
    before_action :ensure_guest_user, only: [:edit]

   def show
     @customer = Customer.find(params[:id])
     @reviews = @customer.review.all
   end

   def edit
     @customer = Customer.find(params[:id])
   end

   def update
     @customer = Customer.find(params[:id])
     @customer.update(customer_params)
     redirect_to customer_path(@customer)
   end

   def destroy
     @customer = current_customer
     if @customer.destroy
       flash[:notice] = "退会が完了しました。"
       redirect_to root_path
     else 
      flash[:alret] = "退会に失敗しました。"
     end  
   end

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

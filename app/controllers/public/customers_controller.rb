class Public::CustomersController < ApplicationController
    before_action :ensure_guest_user, only: [:edit]
  
   def show
     @customer = Customer.find(params[:id])
   
   end
   
   def edit
     @customer = Customer.find(params[:id])
   end
   
   def update
     @customer = Customer.find(params[:id])
     @customer.update(customer_params)
     redirect_to customer_path(@customer)
   end
   
   def quit
   end
   
   def create
   end
      
 private

  def customer_params
    params.require(:customer).permit(:name, :email, :password)
  end

#   def ensure_guest_user
#     @customer = Customer.find(params[:id])
#     if @customer.name == "guestuser"
#       redirect_to customer_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
#     end
#   end      
end

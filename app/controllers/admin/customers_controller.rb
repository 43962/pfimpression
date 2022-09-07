class Admin::CustomersController < ApplicationController
  
  def index
    @customer = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def customer_params
    params.require(:customer).permit(:name, :email, :password)
  end
end

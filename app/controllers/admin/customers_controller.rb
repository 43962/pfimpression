class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all.page(params[:page]).per(10)
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

  def customer_params
    params.require(:customer).permit(:name, :email, :password)
  end
end

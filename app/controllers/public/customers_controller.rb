class Public::CustomersController < ApplicationController

  # before_action :is_matching_login_customer, only: [:show, :edit, :update, :unsubscribe, :withdraw]

  def show
    # @customer = Customer.find(params[:id])
  end

  def edit


  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_deleted)
  end
  # def is_matching_login_customer
  #   customer_id = params[:id].to_i
  #   login_customer_id = current_customer.id
  #   if(customer_id != login_customer_id)
  #     redirect_to root_path(current_customer)
  #   end
  # end
end

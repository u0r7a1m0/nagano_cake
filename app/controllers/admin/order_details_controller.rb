class Admin::OrderDetailsController < ApplicationController
    before_action :authenticate_admin!






  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_deleted)
  end
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :postage, :total_price, :order_status, :payment)
  end
  def order_detail_params
    params.require(:order_detail).permit(:price, :amount, :production_status)
  end
end

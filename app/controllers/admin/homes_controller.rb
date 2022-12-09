class Admin::HomesController < ApplicationController
    before_action :authenticate_admin!

  def top
    # @orders = Order.all
    # @order_details = OrderDetail.all
    @orders = Order.page(params[:page])
    @order_details = OrderDetail.page(params[:page])
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :postage, :total_price, :order_status, :payment)
  end
  def order_detail_params
    params.require(:order_detail).permit(:price, :amount, :production_status)
  end

end

class Admin::HomesController < ApplicationController
    before_action :authenticate_admin!

  def top
    # @orders = Order.all
    # @order = Order.find(params[:id])
    # @order_details = OrderDetail.all
    # @order_detail = OrderDetail.find(params[:id])
    ## ページネーションへ記述変更
    @orders = Order.all.page(params[:page])


  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :postage, :total_price, :order_status, :payment, :customer_id, :address_id)
  end
  def order_detail_params
    params.require(:order_detail).permit(:price, :amount, :production_status,:item_id, :order_id)
  end

end

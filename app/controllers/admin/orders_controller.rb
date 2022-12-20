class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    # @customer = Customer.find(params[:id])
    # @orders = Order.find(params[:id])
    @orders = Order.all.page(params[:page])
    @order = Order.find(params[:id])

    # 一つの注文に対しての情報がこれで取り出せる！
    @order_details = @order.order_details

  end
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    # paramsのカートアイテムの中のamoutを取り出す記述　→　（amoutカラム: params[カートアイテム][数量]）
    if @order.update(order_params)
      @order_details.update(production_status: 1) if @order.order_status == "payment_confirmation"
      flash[:notice]="更新完了しました！"
      redirect_to admin_order_path(@order)
    else
      render :show
    end
    # @order = Order.find(params[:id])
    # if @order.update(order_status: params[:order][:order_status])
    #   flash[:notice]="更新完了しました！"
    #   redirect_to admin_order_path(@order)
    # else
    #   render :show
    # end
  end
  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :postage, :total_price, :order_status, :payment)
  end
  def order_detail_params
    params.require(:order_detail).permit(:price, :amount, :production_status)
  end
  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active, :genre_id)
  end

end

class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    # @customer = Customer.find(params[:id])
    # @orders = Order.find(params[:id])
    @orders = Order.all.page(params[:page])
    @order = Order.find(params[:id])
    # @order_detail = @order.order_details
    # @order_details = OrderDetail.all
    # 一つの注文に対しての情報がこれで取り出せる！
    @order_details = @order.order_details

  end
  def update
    @order = Order.find(params[:id])
    # byebug
    # paramsのカートアイテムの中のamoutを取り出す記述　→　（[amoutカラム]: params[カートアイテム][数量]）
    if @order.update(order_status: params[:order][:order_status])
    # 更新に成功したときの処理
      flash[:notice]="更新完了しました！"
      redirect_to admin_order_path(@order)
    else
      render :show
    end
  end

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
  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active, :genre_id)
  end

end

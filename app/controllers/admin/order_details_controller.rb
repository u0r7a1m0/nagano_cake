class Admin::OrderDetailsController < ApplicationController
    before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    # byebug
    # paramsのカートアイテムの中のamoutを取り出す記述　→　（[amoutカラム]: params[カートアイテム][数量]）
    if @order_detail.update(production_status: params[:order_detail][:production_status])
    # 更新に成功したときの処理
      flash[:notice]="更新完了しました！"
      redirect_to admin_order_path(@order_detail.order.id)
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
end

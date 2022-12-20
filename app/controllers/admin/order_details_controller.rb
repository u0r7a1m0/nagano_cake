class Admin::OrderDetailsController < ApplicationController
    before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
    is_status = true
    if @order_detail.update(production_status: params[:order_detail][:production_status])
      @order.update(order_status: 2) if @order_detail.production_status == "in_production"
      @order_details.each do |order_detail|
        if order_detail.production_status != "production_end"
          is_status = false
        end
      end
      @order.update(order_status: 3) if is_status
      # 更新に成功したときの処理
      flash[:notice]="更新完了しました！"
      redirect_to admin_order_path(@order_detail.order.id)
    else
      render :show
    end
  end

  #   def update
  #   @order_detail = OrderDetail.find(params[:id])
  #   if @order_detail.update(production_status: params[:order_detail][:production_status])
  #   # 更新に成功したときの処理
  #     flash[:notice]="更新完了しました！"
  #     redirect_to admin_order_path(@order_detail.order.id)
  #   else
  #     render :show
  #   end
  # end

  private

  def order_params
    params.require(:order).permit(:order_status, :payment)
  end
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end

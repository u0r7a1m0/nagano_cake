class Public::CartItemsController < ApplicationController

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    # もし元々カート内に「同じ商品」がある場合、「数量を追加」更新・保存する
    #ex.バナナ２個、バナナ２個ではなく　バナナ「4個」にしたい
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      #元々カート内にあるもの「item_id」
      #今追加した params[:cart_item][:item_id])
    cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    cart_item.amount += params[:cart_item][:amount].to_i
    #cart_item.amountに今追加したparams[:cart_item][:amount]を加える
    #.to_iとして数字として扱う
    cart_item.save
    redirect_to cart_items_path

      # もしカート内に「同じ」商品がない場合は通常の保存処理
    elsif @cart_item.save
    @cart_items = current_customer.cart_items.all
    redirect_to cart_items_path
    else # 保存できなかった場合
    render 'index'
    end
  end

  def index
    @cart_items = current_customer.cart_items
    # @items = Item.all.sum(:price)
    @items = Item.all
  end

  def destroy
    # cart_item = current_customer.cart_item
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    render 'index'
  end

  def destroy_all  #カート内全て削除
    cart_items = CartItem.all
    cart_items.destroy_all
    render template: 'cart_items/index'
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:price, :amount, :production_status, :item_id, :customer_id)
  end
  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active, :genre_id)
  end
end

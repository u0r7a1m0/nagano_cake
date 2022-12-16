class Public::CartItemsController < ApplicationController

  def create
    # binding.pry
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if @cart_item.save
      # 投稿成功した場合
      flash[:notice]="カートに入れました！"
      redirect_to cart_items_path
    else
      # 投稿が失敗した場合
      @item = Item.find(params[:id])
      @genres = Genre.all
      render template: "public/items/show"
    end
  end

  def index
    @cart_items = current_customer.cart_items
    @items = Item.all.sum(:price)
    # @items = Item.all
  end

  def destroy
    @cart_item = CartItem.item_id
    @cart_item.destroy
    redirect_to cart_items_path


  end
  def destroy_all
    @cart_items = CartItem
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:price, :amount, :production_status, :item_id, :customer_id)
  end
  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active, :genre_id)
  end
end

class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @items = Item.all
  end

  def create
    # binding.pry
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if @cart_item.save!
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






  def destroy
    @post_image = 削除するPostImageレコードを取得
    @post_image.削除
    redirect_to :index_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:price, :amount, :production_status, :item_id, :customer_id)
  end
  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active)
  end
end

class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @items = Item.all
  end








  def destroy
    @post_image = 削除するPostImageレコードを取得
    @post_image.削除
    redirect_to :index_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:price, :amount, :production_status)
  end
  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active)
  end
end

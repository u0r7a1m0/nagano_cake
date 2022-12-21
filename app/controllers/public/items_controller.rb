class Public::ItemsController < ApplicationController

  def index
    # @items = Item.where(is_active:true).all
    @items = Item.where(is_active:true).all.page(params[:page]).per(10)
    @count = Item.where(is_active:true).all.count
    @genres = Genre.all

  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

  def create
    # binding.pry
    @item = Item.find(params[:id])
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if @cart_item.save
      # 投稿成功した場合
      flash[:notice]="カートに入れました！"
      redirect_to item_path(@item.id)
    else
      # 投稿が失敗した場合

      render :show
    end
  end
  def destroy

  end


  private

  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active, :genre_id)
  end
  def genre_params
    params.require(:genre).permit(:name)
  end
  def cart_item_params
    params.require(:cart_item).permit(:price, :amount, :production_status, :item_id, :customer_id)
  end

end

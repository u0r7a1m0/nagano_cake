class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
    # 投稿成功した場合
    flash[:notice]="You have created item successfully."
    redirect_to item_path(@item.id)
    else
    # 投稿が失敗した場合
    @items=Item.all
    render :index
    end
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])

  end


  private

  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active)
  end

end

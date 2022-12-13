class Admin::ItemsController < ApplicationController
    before_action :authenticate_admin!

  def new
    @item = Item.new

  end

  def create
    @item = Item.new(item_params)
      # binding.pry
    if @item.save
    # 投稿成功した場合
    flash[:notice]="登録完了しました！"
    redirect_to admin_item_path(@item.id)
    else
    # 投稿が失敗した場合
    @items=Item.all
    render :index
    end
  end

  def index
    # @items = Item.all
    @items = Item.all.page(params[:page])
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])

  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
    # 更新に成功したときの処理
      flash[:notice]="更新完了しました！"
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end


  private
  def genre_params
    params.require(:genre).permit(:name)
  end
  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active, :genre_id)
  end

end

class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
    @count = @items.count

  end




    # def create
    # @book = Book.new(book_params)
    # @book.user_id = current_user.id

    # if @book.save
    #   # 投稿成功した場合
    #   flash[:notice]="You have created book successfully."
    #   redirect_to book_path(@book.id)
    # else
    #   # 投稿が失敗した場合
    #   @books=Book.all
    #   render :index
    # end

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
  def genre_params
    params.require(:genre).permit(:name)
  end
end

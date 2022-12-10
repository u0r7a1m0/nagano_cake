class Admin::GenresController < ApplicationController
  # def index
  #   @genre = Genre.new
  #   @genres = Genre.all
  def index
    # urlにcategory_id(params)がある場合
    if params[:genre_id]
      # Categoryのデータベースのテーブルから一致するidを取得
      @genre = Genres.find(params[:genre_id])

      # category_idと紐づく投稿を取得
      @items = @genre.items.order(created_at: :desc).all
    else
      # 投稿すべてを取得
      @items = Item.order(created_at: :desc).all
    end

  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
    # 投稿成功した場合
    flash[:notice]="You have created genre successfully."
    redirect_to genre_path(@genre.id)
    else
    # 投稿が失敗した場合
    @genres=Genre.all
    render :index
    end

  end

  def edit
     @genre = Genre.find(genre_params[:id])
  end

  def update
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active)
  end
end

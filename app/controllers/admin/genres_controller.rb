class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all

  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
    # 投稿成功した場合
    flash[:notice]="You have created genre successfully."
    redirect_to admin_genres_path
    else
    # 投稿が失敗した場合
    @genres=Genre.all
    render :index
    end

  end

  def edit
     @genre = Genre.find(params[:id])
    # @book = Book.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      # 更新に成功したときの処理
      flash[:notice]="You have updated Genre successfully."
      redirect_to admin_genres_path
    else
      render 'edit'
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active)
  end
end

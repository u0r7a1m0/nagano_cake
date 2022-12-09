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

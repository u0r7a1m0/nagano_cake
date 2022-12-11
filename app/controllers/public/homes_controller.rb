class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end

end

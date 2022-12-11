class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.last(4)
    # @items = Item.where(:is_active ==true).and(Customer.where(id: [2, 3]))

  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
  def item_params
    params.require(:item).permit(:name, :item_image, :introduction, :price, :is_active)
  end

end

class Item < ApplicationRecord
  has_one_attached :iimage

  validates :name, :introduction, :price, :is_active, presence: true
  validates :is_active, inclusion:{in: [true, false]}

  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  belongs_to :genres

    ## 小計を求めるメソッド
  def subtotal
    item.with_tax_price * amount
  end
  ## 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

end

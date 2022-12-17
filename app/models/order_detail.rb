class OrderDetail < ApplicationRecord
  validates :price, :amount, presence: true

  belongs_to :order
  belongs_to :item

  enum production_status:{
    start_not_possible: 0, #着手不可
    production_pending: 1, #製作待ち
    in_production: 2, #製作中
    production_end: 3 #製作終了
  }

    ## 小計を求めるメソッド
  def subtotal
    item.with_tax_price * amount
  end
  ## 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
  def full_name
    self.last_name + " " + self.first_name
  end
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + full_name
  end
end

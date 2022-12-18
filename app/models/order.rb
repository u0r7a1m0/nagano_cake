class Order < ApplicationRecord
  validates :postal_code, :address, :name, :postage, :total_price, presence: true

  has_many :order_details
  belongs_to :customer
  has_many :items, through: :order_details

  enum order_status:{
    payment_wating: 0, #入金待ち
    payment_confirmation: 1, #入金確認
    in_product: 2, #製作中
    preparing_delivery: 3, #発送準備中
    delivered: 4 #発送済み
  }
  enum payment:{
    credit_card: 0, #クレジットカード
    bank: 1 #銀行振込
  }
  def full_name
    self.last_name + " " + self.first_name
  end
  def address_display_nameless
    '〒' + postal_code + ' ' + address
  end
  ## 小計を求めるメソッド
  def subtotal
    item.with_tax_price * amount
  end
  ## 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end

end

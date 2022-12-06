class Order < ApplicationRecord
  validates :postal_code, :address, :name, :postage, :total_price, presence: true
  
  enum order_status:{
    payment_wating: 0, #入金待ち
    payment_confirmation: 1, #入金確認
    in_product: 2, #製作中
    preparing_delivery: 3, #発送準備中
    delivered: 4 #発送済み
  }
  enum payment:{
    credit_card:0, #クレジットカード
    bank:1 #銀行振込
  }
  
end

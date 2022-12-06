class OrderDetail < ApplicationRecord
  validates :price, :amount, presence: true
  
  enum production_status:{
    start_not_possible: 0, #着手不可
    production_pending: 1, #製作待ち
    in_production: 2, #製作中
    production_end: 3 #製作終了
  }
end

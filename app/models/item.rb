class Item < ApplicationRecord
  has_one_attached :iimage
  
  validates :name, :introduction, :price, :is_active, presence: true
  validates :is_active, inclusion:{in: [true, false]}

end

class Address < ApplicationRecord
  validates :postal_code,:address,:name, presence: true

  belongs_to :customer
  
  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end

end

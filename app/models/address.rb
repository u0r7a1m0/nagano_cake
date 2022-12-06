class Address < ApplicationRecord
  validates :postal_code,:address,:name, presence: true

end

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

    def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
    end

end

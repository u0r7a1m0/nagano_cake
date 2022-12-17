class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, presence: true
  # validates :is_deleted, inclusion:{in: [true, false]}
  validates :last_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters." }


  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  def full_name
    self.last_name + " " + self.first_name
  end
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + full_name
  end
  def address_display_nameless
    '〒' + postal_code + ' ' + address
  end
  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
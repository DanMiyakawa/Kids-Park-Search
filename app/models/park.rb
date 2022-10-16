class Park < ApplicationRecord

  belongs_to :customer
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many_attached :images

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :name, presence: true
  validates :introduction, presence: true, length: { maximum: 200 }
  validates :address, presence: true

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

end

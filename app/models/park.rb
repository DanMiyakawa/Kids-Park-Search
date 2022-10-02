class Park < ApplicationRecord
  
  has_many_attached :images
  
  belongs_to :customer
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  
end

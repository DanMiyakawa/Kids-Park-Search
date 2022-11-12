class Comment < ApplicationRecord

  belongs_to :customer
  belongs_to :park
  has_many :goods, dependent: :destroy
  has_one_attached :comment_image

  validates :comment, presence: true, length: { maximum: 100 }

  def good_by?(customer)
    goods.exists?(customer_id: customer.id)
  end

end

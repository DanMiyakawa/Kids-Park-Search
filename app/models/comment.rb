class Comment < ApplicationRecord

  belongs_to :customer
  belongs_to :park
  has_one_attached :comment_image

  validates :comment, presence: true, length: { maximum: 50 }

end

class Comment < ApplicationRecord
  
  belongs_to :customer
  belongs_to :park
  has_one_attached :comment_image
  
end

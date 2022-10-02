class Genre < ApplicationRecord
  
  has_many :parks, dependent: :destroy
end

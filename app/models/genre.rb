class Genre < ApplicationRecord

  has_many :parks, dependent: :destroy

  validates :name, presence: true
end

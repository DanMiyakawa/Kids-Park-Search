class Contact < ApplicationRecord

  enum status: {確認中: 0, 対応中: 1, 対応済: 2}

  belongs_to :customer

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 100 }

end

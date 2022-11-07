class Contact < ApplicationRecord

  enum status: {確認中: 0, 対応中: 1, 対応済: 2}
  enum title: {遊び場情報訂正依頼: 0, 遊び場追加情報提供: 1, 不適切な投稿の削除依頼: 2, その他: 3}

  belongs_to :customer
  
  validates :body, presence: true, length: { maximum: 100 }

end

class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :contacts, dependent: :destroy
  has_many :parks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :goods, dependent: :destroy

  validates :nickname, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def self.guest
    find_or_create_by!(nickname: 'ゲストユーザー' ,email: 'guest@example.com') do |customer|
    customer.password = SecureRandom.urlsafe_base64
    customer.nickname = "ゲストユーザー"
    end
  end

end

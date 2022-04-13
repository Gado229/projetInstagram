class User < ApplicationRecord

  mount_uploader :image, ImageUploader
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }, on: :create
  has_many :blogs
  has_many :loves, dependent: :destroy
  has_many :Love_blogs, through: :loves, source: :image
end

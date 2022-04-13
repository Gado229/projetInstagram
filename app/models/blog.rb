class Blog < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :image, presence: true
  mount_uploader :image, ImageUploader
  has_many :loves, dependent: :destroy
  has_many :love_users, through: :loves, source: :user
end

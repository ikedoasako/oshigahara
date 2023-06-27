class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  belongs_to :bushou
  has_many :comments, dependent: :destroy
end

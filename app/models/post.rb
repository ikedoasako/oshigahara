class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  belongs_to :bushou
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
      favorites.exists?(user_id: user.id)
  end


  def self.search(search)
    if search
      Post.where(['title LIKE ? or body LIKE ?', "%#{search}%", "%#{search}%"])
    else
      Post.all
    end
  end

end

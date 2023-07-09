class PostTag < ApplicationRecord

  belongs_to :post
  belongs_to :tag

  #〜複数のタグ付けのための追記〜
  #validates :post_id, presence: true
  #validates :tag_id, presence: true
end

class Tag < ApplicationRecord

  has_many :post_tags, dependent: :destroy
  
  #〜複数のタグ付けのための追記〜
  has_many :posts,through: :post_tags
  #タグは複数の投稿を持っている、タグを持つ投稿はpost_tagを通して見つけてくる
  
end

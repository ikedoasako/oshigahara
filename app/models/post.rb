class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  belongs_to :bushou
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #タグ検索機能の関連付け追加
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

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

  def save_tag(sent_tag_ids)
    current_tag_ids = self.tags.pluck(:id) unless self.tags.nil?
    # タグが存在していれば、タグの名前を配列として全て取得
    #unless~で「タグが存在してるか？」を確認している
    old_tag_ids = current_tag_ids - sent_tag_id
    # 既にタグがある状態で、新しくタグが送られてきたら、今あるタグは古いタグになる（old_tags）
    #新しく送られてきたタグの中に古いタグと同じものがあったら、そのタグだけ残して(current_tags)他はold_tagsに入る

    new_tag_ids = sent_tag_ids - current_tag_ids
    # 過去に登録されていない新規のタグがあったらnew_tags(新規)に入る

    # 古いタグを消すための記述
    old_tag_ids.each do |old_id|
      self.tags.delete　Tag.find_by(id: old_id)
      #新しいタグが来たので古いタグは必要ない
      #old_tagに入っているものを取り出して削除
    end
    #新しいタグを保存するための記述
    new_tag_ids.each do |new_id|
      new_post_tag = Tag.find_or_create_by(id: new_id)
      self.tags << new_post_tag
    #新しいタグnew_tagに入っているものを取り出して保管する
    end
  end

end

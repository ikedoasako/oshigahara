class Batch::DataReset
  
   # data_totalにて前日のいいねと投稿の合計数を表示するメソット
  def self.data_total
    Bushou.update_all(tally: nil)
    date_range = Time.zone.yesterday.all_day
    #date_range = Time.zone.today.all_day
    post_counts = Post.where(created_at: date_range).group(:bushou_id).count
    favorite_counts = Favorite.where(created_at: date_range).joins(:post).group('posts.bushou_id').count
    post_counts.each do |k, v|
      bushou = Bushou.find(k)
      post_point = v
      favorite_point = favorite_counts[k] || 0
      bushou.tally = post_point + favorite_point
      bushou.save!
    end
  end
  
  def self.data_reset
    # old_bushouを全て削除
    users = User.all
    users.each do |user|
      user.update(old_bushou_id: nil)
    end
    p "前所属を全て取り消しました"
  end
end
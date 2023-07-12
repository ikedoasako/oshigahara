class Batch::DataReset
  def self.data_reset
    # old_bushouを全て削除
    users = User.all
    users.each do |user|
      user.update(old_bushou_id: nil)
    end
    p "前所属を全て取り消しました"
  end
end
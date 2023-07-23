Admin.create!(
  email: 'piyo@maru',## 任意のメールアドレス,
  password: 'qwertyu'## 任意のパスワード
)

#〜タグ検索用の追記〜
Tag.create([
  { name: '戦国武将' },
  { name: '有名' },
  { name: '名言' },
  { name: '戦略'},
  { name: '戦法'},
  { name: '戦国大名の城' },
  { name: '難攻不落の城'},
  { name: '城主' },
  { name: '城跡'},
  { name: '屋敷跡'},
  { name: '城下町'},
  { name: '合戦跡地'},
  { name: '歴史資料館'},
  { name: '歴史' },
  { name: '日本刀'},
  { name: '刀剣'},
  { name: '愛刀'},
  { name: '神社'},
  { name: '聖地' },
  { name: '観光'},
  { name: '行ってみたい' },
  { name: 'おすすめ'}
  ])
#〜ここまで〜


bushou_params = [
  {:bushou_name=>"織田信長", :explanation=>"1560年（永禄3年）、駿河の「今川義元」と対峙した「桶狭間の戦い」が有名"},
  {:bushou_name=>"上杉謙信", :explanation=>"武田軍は意表を突いた「車懸りの陣」（くるまがかりのじん）が有名"},
  {:bushou_name=>"伊達政宗", :explanation=>"あと10年、20年生まれるのが早ければ天下人となっていたかもしれない"},
  {:bushou_name=>"真田幸村", :explanation=>"真田幸村という名前が有名ですが、実名は「真田信繁」（さなだのぶしげ）"},
  {:bushou_name=>"徳川家康", :explanation=>"天下分け目の「関ヶ原の戦い」を経て征夷大将軍となった"},
  {:bushou_name=>"豊臣秀吉", :explanation=>"「墨俣一夜城」（すのまたいちやじょう）や「金ヶ崎の退き口」（かねがさきののきくち）など様々な逸話を残した"},
  {:bushou_name=>"武田信玄", :explanation=>"好敵手「上杉謙信と」「川中島の戦い」で1553～1564年（天文22年～永禄7年）の11年間のうちに5度も戦う"},
  {:bushou_name=>"黒田官兵衛", :explanation=>"様々な戦略を押し出した稀代の知将"},
  {:bushou_name=>"明智光秀", :explanation=>"「長篠の戦い」、「天王寺の戦い」、「有岡の戦い」など数々の戦に参戦"},
  {:bushou_name=>"石田三成", :explanation=>"主君である豊臣秀吉への忠義を生涯貫いた"}
]
bushou_params.each do |attributes|
  Bushou.create!(attributes)
end

bushou_count = Bushou.all.size

User.create!(name: "ゲスト", email: "guest@example.com", password: "password", bushou_id: 1)

#集計用にランダムに武将idを持たせたuserを作成する（20名）
(1..20).each.with_index(1) do |n, i|
  user = User.new(
    name: "user#{n}",
    email: "user#{n}@example.com",
    password: "password",
    bushou_id: rand(1..bushou_count),
  )
  #寝返り回数を表示させるため、1〜3名の寝返りuserを作成し武将にランダム表示させる
  if i % 3 == 0 && user.bushou_id != 1
    user.old_bushou_id = user.bushou_id - 1
  end
  #集計用に武将の投稿を5〜10件にランダムに作成
  user.save!
  (1..rand(1..3)).each do |m|
    user.posts.create!(
      bushou_id: rand(1..bushou_count),
      title: "post#{n}_#{m}",
      body: "text" * rand(5..10)
    )
  end
end

posts = Post.all
users = User.all.sample(10)

#集計用に投稿の数だけいいねをランダムに作成
users.each do |user|
  (1..rand(1..posts.size)).each do |n|
    user.favorites.create!(post_id: n)
  end
end

# 開発環境
if Rails.env.development?

end
# rails db:migrate:reset
# rails db:seed


#本番環境
if Rails.env.production?

end
#  RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop
# rails db:create RAILS_ENV=production
# rails db:migrate RAILS_ENV=production
# rails db:seed RAILS_ENV=production

# rails c -e production



# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

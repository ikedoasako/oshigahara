Admin.create!(
  email: 'piyo@maru',## 任意のメールアドレス,
  password: 'qwertyu'## 任意のパスワード
)

#〜タグ検索用の追記〜
Tag.create([
  { name: '戦国大名の城' },
  { name: '城主' },
  { name: '城跡'},
  { name: '屋敷跡'},
  { name: '難攻不落の城'},
  { name: '城下町'},
  { name: '歴史資料館'},
  { name: '日本刀'},
  { name: '刀剣'},
  { name: '愛刀'},
  { name: '戦略'},
  { name: '戦法'},
  { name: '合戦場跡地'},
  { name: '神社'},
  { name: '観光名所'},
  { name: 'おすすめ'}
  ])
#〜ここまで〜


bushou_params = [
  {:bushou_name=>"織田信長", :explanation=>"安土城"},
  {:bushou_name=>"上杉謙信", :explanation=>"春日城"},
  {:bushou_name=>"伊達政宗", :explanation=>"青葉城"},
  {:bushou_name=>"真田幸村", :explanation=>"六文銭"},
  {:bushou_name=>"徳川家康", :explanation=>"日光東照宮"},
  {:bushou_name=>"豊臣秀吉", :explanation=>"大阪城"},
  {:bushou_name=>"武田信玄", :explanation=>"甲斐の虎"},
  {:bushou_name=>"黒田官兵衛", :explanation=>"カリスマ"},
  {:bushou_name=>"明智光秀", :explanation=>"麒麟が来る"},
  {:bushou_name=>"石田三成", :explanation=>"頭脳派の智将"}
]
bushou_params.each do |attributes|
  Bushou.create!(attributes)
end

bushou_count = Bushou.all.size

User.create!(name: "ゲスト", email: "guest@example.com", password: "password", bushou_id: 1)

(1..20).each.with_index(1) do |n, i|
  user = User.new(
    name: "user#{n}",
    email: "user#{n}@example.com",
    password: "password",
    bushou_id: rand(1..bushou_count),
  )
  if i % 3 == 0 && user.bushou_id != 1
    user.old_bushou_id = user.bushou_id - 1
  end
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

users.each do |user|
  (1..rand(1..posts.size)).each do |n|
    user.favorites.create!(post_id: n)
  end
end

if Rails.env.development?
  
end

if Rails.env.production?
  
end




# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

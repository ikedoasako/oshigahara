# Admin.create!(
#   email: 'piyo@maru',## 任意のメールアドレス,
#   password: 'qwertyu'## 任意のパスワード
# )

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


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

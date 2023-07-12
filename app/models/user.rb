class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :bushou
  belongs_to :old_bushou, class_name: "Bushou", foreign_key: :old_bushou_id, optional: true
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #〜ゲストユーザーの追加〜
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
    #ゲストユーザーがあれば取り出す、なければ作成することができる
      user.password = SecureRandom.urlsafe_base64
      #パスワードはランダム
      user.bushou_id = 1
      #ゲストユーザーにid(1)の武将を持たせる
      user.name = 'ゲスト'
      #ユーザー名はゲストで登録

    end
  end

end

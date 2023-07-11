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

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.bushou_id = 1
      # user.confirmed_at = Time.now
      user.name = 'ゲスト'

    end
  end

end

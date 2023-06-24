class Bushou < ApplicationRecord

  has_one_attached :image
  has_many :users, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :betrays, dependent: :destroy

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end

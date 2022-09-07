class Review < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :comments, dependent: :destroy
  
  validates :name, presence: true
  validates :height, presence: true
  validates :weight, presence: true
  validates :image, presence: true
  validates :item_name, presence: true
  validates :review, presence: true

  def get_image
     unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
       image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
     end
     image
  end
end

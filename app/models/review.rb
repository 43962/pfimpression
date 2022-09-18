class Review < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  scope :published, -> { where(is_draft: false) }

  with_options presence: true, on: :publicize do
    validates :height, presence: true
    validates :weight, presence: true
    validates :item_name, presence: true
    validates :category_id, presence: true
    validates :review, presence: true, length: { maximum: 80 }
  end

def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
end

  def get_image
     unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
       image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
     end
     image
  end
end

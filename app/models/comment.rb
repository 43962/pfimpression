class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :review

  # 空をバリデーション、文字数制限
  validates :comment, presence: true, length: { maximum: 50 }
end

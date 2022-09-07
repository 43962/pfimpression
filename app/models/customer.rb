class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :review, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  # def self.guest
  #   find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
  #     user.password = SecureRandom.urlsafe_base64
  #     user.name = "guestuser"
  #   end
  # end

end

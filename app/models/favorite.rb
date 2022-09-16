class Favorite < ApplicationRecord
  belongs_to :review
  belongs_to :customer
  
end

class Recipe < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 255 }
  validates :ingredient, presence: true, length: { maximum: 500 }
  validates :howto, presence: true, length: { maximum: 500 }
  
  
  
end

class Novel < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :text, presence: true
  
  has_many :favorites
  has_many :like_user, through: :favorites, source: :user
end

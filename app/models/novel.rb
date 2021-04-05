class Novel < ApplicationRecord
  belongs_to :user #userモデルとの紐付け
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :text, presence: true, length: { maximum: 100000 }
  
  has_many :favorites #favoriteモデルとの紐付け
  has_many :like_user, through: :favorites, source: :user #favoriteモデルに紐付いているuserモデルとの紐付け
  
  has_many :links
  has_many :link_subject, through: :links, source: :subject
  
  def connect(subject)
    self.links.create(subject_id: subject.id)
  end
end

class Novel < ApplicationRecord
  belongs_to :user #userモデルとの紐付け
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :text, presence: true, length: { maximum: 100000 }
  
  has_many :favorites, dependent: :destroy #Favoriteモデルとの紐付け
  has_many :like_user, through: :favorites, source: :user #Favoriteモデルに紐付いているUserモデルとの紐付け
  
  has_many :links, dependent: :destroy #Linkモデルとの紐付け
  has_many :link_subject, through: :links, source: :subject #Linkモデルに紐付いているSubjectモデルとの紐付け
  
  #Subjectモデルとの紐付け処理
  def connect(subject)
    self.links.create(subject_id: subject.id)
  end
end

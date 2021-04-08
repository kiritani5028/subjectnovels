class Subject < ApplicationRecord
  belongs_to :word
  
  has_many :links, dependent: :destroy #Linkモデルとの紐付け
  has_many :link_novel, through: :links, source: :novel #Linkモデルに紐付いているNovelモデルとの紐付け
end

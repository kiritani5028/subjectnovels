class Subject < ApplicationRecord
  belongs_to :word
  
  has_many :links
  has_many :link_novel, through: :links, source: :novel
end

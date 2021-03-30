class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    has_many :novels
    
    has_many :favorites
    has_many :like_novel, through: :favorites, source: :novel
    
    def like(novel)
      self.favorites.find_or_create_by(novel_id: novel.id)
    end
    
    def unlike(novel)
      favorite = self.favorites.find_or_create_by(novel_id: novel.id)
      favorite.destroy if favorite
    end
    
    def like?(novel)
      self.like_novel.include?(novel)
    end
end

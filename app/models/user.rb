class User < ApplicationRecord
    before_save { self.email.downcase! } #メールアドレス小文字化
    validates :name, presence: true, length: { maximum: 50 } #空欄禁止　50文字まで
    validates :email, presence: true, length: { maximum: 255 }, #空欄禁止　255文字まで　重複禁止
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    has_many :novels, dependent: :destroy #novelモデルとの紐付け
    
    has_many :favorites, dependent: :destroy #favoriteモデルとの紐付け
    has_many :like_novel, through: :favorites, source: :novel #favoriteモデルに紐付いているnovelモデルとの紐付け
    
    #指定した小説をお気に入りに追加
    def like(novel)
      self.favorites.find_or_create_by(novel_id: novel.id)
    end
    
    #指定した小説をお気に入りから解除
    def unlike(novel)
      favorite = self.favorites.find_or_create_by(novel_id: novel.id)
      favorite.destroy if favorite
    end
    
    #指定した小説がお気に入りに追加されているか確認
    def like?(novel)
      self.like_novel.include?(novel)
    end
end

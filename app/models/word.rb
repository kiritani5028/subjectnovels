class Word < ApplicationRecord
    validates :content, uniqueness: true, length: { maximum: 50 } #空欄禁止　50文字まで
    
    has_many :subjects, dependent: :destroy
end

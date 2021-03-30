class Word < ApplicationRecord
    validates :content, uniqueness: true
end

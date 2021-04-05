class Link < ApplicationRecord
  belongs_to :subject
  belongs_to :novel
end

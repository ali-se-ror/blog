class Card < ApplicationRecord
  belongs_to :list
  has_many :comments
  belongs_to :user
end
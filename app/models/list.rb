class List < ApplicationRecord
  has_many :cards
  has_many :list_users
  has_many :users, through: :list_users
end
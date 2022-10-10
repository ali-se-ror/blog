class User < ApplicationRecord
  has_secure_password
  enum role: [:admin, :member]
  after_initialize :set_default_role, :if => :new_record?

  has_many :lists
  has_many :cards

  has_many :list_users
  has_many :users, through: :list_users

  has_many :comments

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  def set_default_role
    self.role ||= :member
  end
end

class User < ApplicationRecord
  has_one :profile
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email address' }
end

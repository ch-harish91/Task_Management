class User < ApplicationRecord
  has_one :profile
  belongs_to :organization

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email address' }
end

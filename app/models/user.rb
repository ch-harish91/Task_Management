class User < ApplicationRecord
  has_one :profile
  belongs_to :organization
  has_and_belongs_to_many :roles
  has_many :userprojects
  has_many :projects, through: :userprojects

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email address' }
end

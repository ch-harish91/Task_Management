class Project < ApplicationRecord
  has_many :userprojects
  has_many :users, through: :userprojects

  belongs_to :organization 
  validates :organization_id, presence: true
end

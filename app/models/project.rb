class Project < ApplicationRecord
  belongs_to :user

  has_many :boards, dependent: :destroy
  has_many :conferences, dependent: :destroy
  has_many :project_permissions, dependent: :destroy
  has_many :labels, dependent: :destroy
  has_many :users, through: :project_permissions

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :description, presence: true, length: { minimum: 3, maximum: 250 }
  validates :user_id, presence: true
end

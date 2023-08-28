class Board < ApplicationRecord
  belongs_to :project

  has_many :tasks, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :description, presence: true, length: { minimum: 3, maximum: 250 }
  validates :project_id, presence: true
end

class Label < ApplicationRecord
  belongs_to :project

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :color, presence: true, length: { minimum: 3, maximum: 25 }
  validates :project_id, presence: true
end

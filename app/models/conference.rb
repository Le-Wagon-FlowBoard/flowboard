class Conference < ApplicationRecord
  belongs_to :project

  has_many :messages, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :date, presence: true
  validates :project_id, presence: true
end

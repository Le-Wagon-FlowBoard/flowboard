class Task < ApplicationRecord
  belongs_to :board

  has_many :assignees, dependent: :destroy
  has_many :subtask_groups, dependent: :destroy
  has_many :task_labels, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :description, presence: true, length: { minimum: 3, maximum: 250 }
  validates :board_id, presence: true
end

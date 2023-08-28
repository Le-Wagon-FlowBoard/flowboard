class SubtaskGroup < ApplicationRecord
  belongs_to :task

  has_many :subtasks, dependent: :destroy

  validates :task_id, presence: true
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
end

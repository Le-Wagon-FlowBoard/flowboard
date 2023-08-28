class Subtask < ApplicationRecord
  belongs_to :subtask_group

  validates :subtask_group_id, presence: true
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
end

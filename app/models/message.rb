class Message < ApplicationRecord
  belongs_to :conference
  belongs_to :user

  validates :conference_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 1, maximum: 1000 }
end

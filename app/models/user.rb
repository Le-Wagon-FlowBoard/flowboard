class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  has_many :project_permissions, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :assignees, dependent: :destroy

  validates :first_name, presence:true
  validates :last_name, presence:true
end

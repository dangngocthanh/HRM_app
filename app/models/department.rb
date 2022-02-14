class Department < ApplicationRecord
  has_one :user
  has_many :projects
  has_many :users_departments
  has_many :users, through: :users_departments

  validates :name, uniqueness: true, presence: true
  validates :user_id, presence: true
end

class Project < ApplicationRecord
  has_one :user
  has_many :users_projects
  has_one :department

  validates :user_id, presence: true
  validates :department_id, presence: true
  validates :name, presence: true
end

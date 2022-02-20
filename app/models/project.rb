class Project < ApplicationRecord
  has_one :user
  has_many :users_projects
  belongs_to :department, foreign_key: :department_id, class_name: Department.to_s, optional: true

  validates :user_id, presence: true
  validates :name, presence: true
end

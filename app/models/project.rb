class Project < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, class_name: User.to_s, optional: true

  has_many :users_projects
  has_many :users, through: :users_projects

  belongs_to :department, foreign_key: :department_id, class_name: Department.to_s, optional: true

  validates :name, presence: true

  def pm_dp
    department.pm
  end

  def leader_pj
    user
  end
end

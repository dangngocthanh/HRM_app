class Department < ApplicationRecord
  belongs_to :project_manager, foreign_key: :user_id, class_name: User.to_s, optional: true

  has_many :projects
  has_many :users_departments
  has_many :users, through: :users_departments

  validates :name, uniqueness: true, presence: true
  validate :pm_user_validation, on: :update

  def maybe_pm_users
    User.where(id: users.ids)
  end

  def user_in_department
    User.where(id: users.ids)
  end

  def free_user
    User.where.not(id: UsersDepartment.select(:user_id))
  end

  def pm_user_validation
    return if users.exists?(id: user_id)
    errors.add(:user_id, "can thuoc danh sach users")
  end

  def pm
    project_manager
  end
end

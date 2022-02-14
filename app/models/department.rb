class Department < ApplicationRecord
  belongs_to :project_manager, foreign_key: :user_id, class_name: User.to_s
  has_many :projects
  has_many :users_departments
  has_many :users, through: :users_departments

  validates :name, uniqueness: true , presence: true
  validates :user_id, presence: true
  validate :pm_user_validation

  def maybe_pm_users
    User.where(id: users.ids + User.where.not(id: UsersDepartment.select(:user_id)).ids)
  end

  def pm_user_validation
    return if users.exists?(id: user_id)
    errors.add(:user_id, "can thuoc danh sach users")
  end
end

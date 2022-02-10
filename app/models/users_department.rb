class UsersDepartment < ApplicationRecord
  belongs_to :user
  belongs_to :department

  validates :user_id, presence: true
  validates :department_id, presence: true
end

class UsersProject < ApplicationRecord
  belongs_to :user
  belongs_to :project, foreign_key: :project_id, class_name: Project.to_s

end

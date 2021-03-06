class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def index?

  end

  def new?
    user.information.admin?
  end

  def create?
    user.information.admin?
  end

  def users_projects_detail?

  end

  def change_leader?
    user.information.admin? || user == @project.pm
  end

  def update_leader?
    user.information.admin? || user == @project.pm
  end

  def done_project?
    user.information.admin? || user == @project.pm
  end

  def destroy?
    user.information.admin?
  end

  def all_project?
    user.information.admin? || user.information.hr?
  end

  def pm?

  end

end

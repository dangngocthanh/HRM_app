class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def index?

  end

  def edit?
    user.information.admin? || user == @project.pm_dp
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
    user.information.admin? || user == @project.pm_dp
  end

  def update_leader?
    user.information.admin? || user == @project.pm_dp
  end

  def done_project?
    user.information.admin? || user == @project.pm_dp
  end

  def projects_done?

  end

  def destroy?
    user.information.admin?
  end

  def all_project?
    user.information.admin? || user.information.hr?
  end

  def ad_hr_pm?
    user.information.admin? || user.information.hr? || user == @project.pm_dp
  end

  def pm?
    user == @project.pm_dp
  end

end

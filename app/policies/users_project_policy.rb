class UsersProjectPolicy < ApplicationPolicy
  attr_reader :user, :users_project

  def initialize(user, users_project)
    @user = user
    @users_project = users_project
  end

  def edit?
    @user.information.admin? || user == @users_project.pm_dp
  end

  def change_leader?
    @user.information.admin? || @user == @users_project.pm
  end

  def update_leader?
    @user.information.admin? || @user == @users_project.pm
  end

  def done_project?
    @user.information.admin? || @user == @users_project.pm
  end

end

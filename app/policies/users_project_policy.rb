class UsersProjectPolicy < ApplicationPolicy
  attr_reader :user, :users_project

  def initialize(user, users_project)
    @user = user
    @users_project = users_project
  end

  def new?
    user.information.admin? || user.information.pm?
  end
end

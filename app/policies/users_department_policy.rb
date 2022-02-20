class UsersDepartmentPolicy < ApplicationPolicy
  attr_reader :user, :users_department

  def initialize(user, users_department)
    @user = user
    @users_department = users_department
  end

  def new?
    user.information.admin?
  end

  def create?

  end

  def show?

  end

  def all_project?
    user.information.admin? || user.information.hr?
  end
end

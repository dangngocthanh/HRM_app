class UserDepartmentPolicy < ApplicationPolicy
  attr_reader :user, :users_department

  def initialize(user, users_department)
    @user = user
    @users_department = users_department
  end

  def new?
    user.information.admin? || user
  end

  def create?

  end

  def show?

  end
end

class DepartmentPolicy < ApplicationPolicy
  attr_reader :user, :department

  def initialize(user, department)
    @user = user
    @department = department
  end

  def index?
    user.information.admin?
  end

  def show?
    user.information.admin?
  end

  def new?
    user.information.admin?
  end

  def create?
    user.information.admin?
  end

  def update?
    user.information.admin?
  end

  def destroy?
    user.information.admin?
  end
end
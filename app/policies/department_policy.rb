class DepartmentPolicy < ApplicationPolicy
  attr_reader :user, :department

  def initialize(user, department)
    @user = user
    @department = department
  end

  def index?
    user.information.admin? || user.information.hr?
  end

  def show?
    user.information.admin? || user.information.hr? || department.users.exists?(id: user.id)
  end

  def new?
    user.information.admin?
  end

  def create?
    user.information.admin?
  end

  def edit?
    user.information.admin?
  end

  def update?
    user.information.admin?
  end

  def destroy?
    user.information.admin?
  end

  def information?
    user.information.admin? || user == @department.pm || user.information.hr?
  end

  def operation?
    user.information.admin? || user == @department.pm
  end

  def pm?
    user == @department.pm
  end
end

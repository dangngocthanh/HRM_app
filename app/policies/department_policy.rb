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
    user.information.admin? || user.information.hr? || current_user.department.id == params[:id]
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
end

class UserPolicy < ApplicationPolicy
  attr_reader :user, :users

  def initialize(user, users)
    @user = user
    @users = users
  end

  def index?
    user.information.admin? || user.information.hr?
  end

  def new?
    user.information.admin?
  end

end

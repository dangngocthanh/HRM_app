class RegistrationPolicy < ApplicationPolicy
  attr_reader :user, :registration

  def initialize(user, registration)
    @user = user
    @registration= registration
  end

  def new?
    user.information.admin?
  end
end

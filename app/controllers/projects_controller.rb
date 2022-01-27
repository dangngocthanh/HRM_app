class ProjectsController < ApplicationController
  before_action :admin, only: [:create, :new]

  def new
  end

  def create
    @project = Project.new
  end

  private

  def admin
    user = current_user
    p user
    if user.id = 1
    else
      redirect_to '/users/sign_in'
    end
  end
end

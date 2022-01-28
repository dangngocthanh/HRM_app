class ProjectsController < ApplicationController
  before_action :admin, only: [:create, :new]

  def new
    @departments = Department.all
  end

  def create
    department_id = params['project']['department_id']
    p department_id
    @project = Project.new(params_project)
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

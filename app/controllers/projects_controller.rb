class ProjectsController < ApplicationController
  before_action :admin, only: [:create, :new]

  def new
    @departments = Department.all
    @project = Project.new
  end

  def create
    department_id = params['project']['department_id']
    @department = Department.find(department_id)
    user_id = @department.user_id
    p 123
    @project = Project.new(name: params['project']['name'],department_id: department_id, user_id: user_id, status: false)
    if @project.save
    end
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

class ProjectsController < ApplicationController
  before_action :admin, only: [:create, :new]

  def index
    user = current_user
    if user.role_id == 3
      department = Department.where(user_id: user.id)
      department_id = department[0].id
      @projects = Project.where(department_id: department_id)
    else
      @projects = UsersProject.where(user_id: user.role_id)
    end
  end

  def new
    @departments = Department.all
    @project = Project.new
  end

  def create
    department_id = params['project']['department_id']
    @department = Department.find(department_id)
    user_id = @department.user_id
    @project = Project.new(name: params['project']['name'], department_id: department_id, user_id: user_id, status: false)
    if @project.save
      add_user_to_users_projects(user_id)
    end
  end

  def users_projects_detail
    session[:id] = params[:id]
    redirect_to users_projects_path
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

  def add_user_to_users_projects(user_id)
    id = Project.all.order('id desc')
    id = id.limit(1)
    id = id[0].id
    @users_department = UsersProject.new(project_id: id, user_id: user_id)
    @users_department.save
  end

end

class ProjectsController < ApplicationController
  before_action :IsAdmin?, only: [:create, :new]
  before_action :admin_or_PM, only: [:change_leader, :done_project, :update_leader]

  def index
    user = current_user
    if user.information.role_id == 4
      @projects = UsersProject.where(user_id: user.id)
    else
      if user.information.role_id < 4
        @projects = Project.where(department_id: session[:department_id])
      end
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

  def change_leader
    @project_id = params[:id]
    @users = UsersDepartment.where(department_id: session[:department_id])
    @leader = []
    @users.each do |user|
      @leader.push(Information.where(user_id: user.user_id))
    end
    project = Project.find(params[:id])
    @current_leader = User.find(project.user_id)
  end

  def update_leader
    @project_change = Project.find(params[:id])
    @project_change.update(user_id: params['project']['user_id'])
  end

  def done_project
    @project = Project.find(params[:id])
    @project.update(status: true)
    @project.save
    redirect_to action: :index
  end

  private

  def add_user_to_users_projects(user_id)
    id = Project.all.order('id desc')
    id = id.limit(1)
    id = id[0].id
    @users_department = UsersProject.new(project_id: id, user_id: user_id)
    @users_department.save
  end

  def admin_or_PM
    user = current_user
    if user.information.role_id == 1 || user.information.role_id == 3
    else
      redirect_to action: :index
    end
  end
end

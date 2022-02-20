class ProjectsController < ApplicationController
  # before_action :IsAdmin?, only: [:create, :new]
  before_action :done?, only: [:change_leader, :destroy, :update_leader]
  layout "dashboard"

  def index
    user = current_user
    if user.information.admin? || user.information.hr?
      @projects = Project.all
    else
      @projects = [current_user.projects]
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
      PM_to_leader(user_id)
    end
  end

  def users_projects_detail
    session[:id] = params[:id]
    redirect_to users_projects_path
  end

  def change_leader
    @project = Project.find(params[:id])
    authorize @project
  end

  def update_leader
    @project_change = Project.find(params[:id])
    @project_change.update(user_id: params[:user_id])
    redirect_to change_leader_path(params[:id])
  end

  def done_project
    @project = Project.find(params[:id])
    @project.update(status: true)
    @project.save
    redirect_to action: :changeStatus
  end

  def restart_project
    @project = Project.find(params[:id])
    @project.update(status: false)
    @project.save
    redirect_to action: :changeStatus
  end

  def changeStatus
    if session[:status]
      session[:status] = false
    else
      session[:status] = true
    end
    redirect_to action: :index
  end

  def destroy
    UsersProject.destroy(params[:id])
  end

  private

  def done?
    @project = Project.find(params[:id])
    if @project.status == true
      redirect_to action: :index
    end
  end

  def PM_to_leader(user_id)
    id = Project.last.id
    @users_department = UsersProject.new(project_id: id, user_id: user_id)
    @users_department.save
  end

end

class ProjectsController < ApplicationController
  # before_action :IsAdmin?, only: [:create, :new]
  before_action :done?, only: [:change_leader, :destroy, :update_leader]
  layout "dashboard"

  def index
    user = current_user
    if user.information.employee?
      @projects = UsersProject.where(user_id: user.id)
      if @projects.blank?
        @department_id = nil
      else
        department_id = UsersDepartment.where(user_id: current_user.id)
        @department_id = department_id[0].department_id
      end
    else
      if user.information.pm?
        department_id = UsersDepartment.where(user_id: current_user.id)
        @department_id = department_id[0].department_id
        @projects = Project.where(department_id: @department_id)
      else
        if user.information.admin? || user.information.hr?
          @projects = Project.all
        end
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
      PM_to_leader(user_id)
    end
  end

  def users_projects_detail
    session[:id] = params[:id]
    redirect_to users_projects_path
  end

  def change_leader
    @project_id = params[:id]
    @project = Project.find(@project_id)
    session[:project_update_id] = @project_id
    @users = UsersDepartment.where(user_id: current_user.id)
    user_id = @users.ids
    @users = UsersDepartment.where(department_id: user_id)
    @leader = []
    project = Project.find(params[:id])
    @current_leader = User.find(project.user_id)
    @users.each do |user|
      if user.user_id == @current_leader.id
        next
      end
      @leader.push(User.where(id: user.user_id)[0])
    end

  end

  def update_leader
    @project_change = Project.find(session[:project_update_id])
    @project_change.update(user_id: params[:user_id])
    add_user_to_users_projects(params[:user_id], params[:id])
    redirect_to action: :index
  end

  def done_project
    @project = Project.find(params[:id])
    @project.update(status: true)
    @project.save
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

  def add_user_to_users_projects(user_id, project_id)
    if UsersProject.where(user_id: user_id, project_id: project_id).blank?
      @users_department = UsersProject.new(project_id: project_id, user_id: user_id)
      @users_department.save
    end
  end

  def PM_to_leader(user_id)
    id = Project.last.id
    @users_department = UsersProject.new(project_id: id, user_id: user_id)
    @users_department.save
  end

end

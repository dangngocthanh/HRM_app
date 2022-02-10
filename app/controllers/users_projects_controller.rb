class UsersProjectsController < ApplicationController
  layout "dashboard"

  def index
    p session[:id]
    @users = UsersProject.where(project_id: session[:id])
  end

  def new
    @projects = Project.where(department_id: session[:department_id])
    @users = UsersDepartment.where(department_id: session[:department_id])
    @users = RoleToUser(@users)
  end

  def create
    if UsersProject.where(user_id: params['user_id'], project_id: params['project_id']).blank?
      @users_projects = UsersProject.new(project_id: params['project_id'], user_id: params['user_id'])
      if @users_projects.save
        redirect_to action: :new
      end
    end
  end

  def destroy
    UsersProject.destroy(params[:id])
  end
end

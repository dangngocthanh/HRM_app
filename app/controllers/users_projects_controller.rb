class UsersProjectsController < ApplicationController
  layout "dashboard"

  def index
    p session[:id]
    @users = UsersProject.where(project_id: session[:id])
  end

  def show
    @users = []
    @project = Project.find(params[:id])
    if current_user.information.admin? || current_user.information.hr?
      @users = UsersProject.where(project_id: params[:id])
    else
      if current_user.information.pm?
        department_id = Department.where(user_id: current_user.id)[0].id
        @projects = Project.find(params[:id])
        if department_id == @projects.department_id
          @users = UsersProject.where(project_id: params[:id])
        end
      else
        if UsersProject.where(project_id: params[:id], user_id: current_user.id)
          @users = UsersProject.where(project_id: params[:id])
        end
      end
    end
  end

  def edit
    @project = Project.find(params[:id])
    @users_department = UsersDepartment.where(department_id: @project.department_id)
    @users_in_project = UsersProject.where(project_id: @project.id)
    @users = []
    @users_department.each do |user1|
      count = 0
      @users_in_project.each do |user2|
        if user1.user_id == user2.user_id
          count = count + 1
        end
      end
      if count == 0
        @users.push(user1)
      end
    end
    @users = RoleToUser(@users)
  end

  # def new
  #   @projects = Project.where(department_id: session[:department_id])
  #   @users = UsersDepartment.where(department_id: session[:department_id])
  #   @users = RoleToUser(@users)
  # end

  def update
    if UsersProject.where(user_id: params[:user_id], project_id: params[:id]).blank?
      @users_projects = UsersProject.new(project_id: params[:id], user_id: params[:user_id])
      if @users_projects.save
        redirect_to users_project_path(params[:id])
      end
    end
  end

  def destroy
    UsersProject.destroy(params[:id])
  end
end

class UsersDepartmentsController < ApplicationController
  layout "dashboard"

  def new
    @department = Department.find(params[:id])
    @users = @department.free_user
    @users_department = UsersDepartment.new
    authorize @users_department
  end

  def create
    if User.find(params['users_department']['user_id']).department.nil?
      UsersDepartment.create(user_id: params['users_department']['user_id'], department_id:  params['department_id'])
    end
    redirect_to department_path(params['department_id'])
  end

  def destroy

    user = User.find(params[:id])

    user.projects.where(user_id: user.id, status: false).update(user_id: nil)

    UsersProject.delete(UsersProject.where(project_id: user.projects.where(status: false).ids, user_id: user.id).ids)

    if user.department.user_id == user.id
      user.department.update(user_id: nil)
    end
    UsersDepartment.delete(UsersDepartment.where(user_id: params[:id]).ids)

  end

  def show
    @department = UsersDepartment.where(user_id: params[:id])[0]
    @user = User.find(params[:id])
    @projects = UsersProject.where(user_id: params[:id])
    @done_projects = []
    @doing_projects = []
    @projects.each do |project|
      project = Project.find(project.project_id)
      if project.status == true && project.department_id == @department.department_id
        @done_projects.push(project)
      else
        @doing_projects.push(project)
      end
    end
  end

end

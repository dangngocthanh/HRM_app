class UsersDepartmentsController < ApplicationController
  layout "dashboard"

  def new
    @departments = Department.all
    @users = Information.where(has_department: false).where('role_id !=1 and role_id !=2')
    @users = RoleToUser(@users)
    @users_department = UsersDepartment.new
  end

  def create
    if UsersDepartment.where(user_id: params['users_department']['user_id']).blank?
      @users_department = UsersDepartment.new(user_id: params['users_department']['user_id'], department_id: params['users_department']['department_id'])
      if @users_department.save
        @user = Information.where(user_id: params['users_department']['user_id'])
        @user.update(has_department: true)
      end
    end
    redirect_to department_path(params['users_department']['department_id'])
  end

  def destroy
    id = params[:id]
    @users_projects = UsersProject.where(user_id: id)
    @users_projects.each do |users_projects|
      if Project.find(users_projects.project_id).status == false
        UsersProject.destroy(users_projects.id)
        project = Project.find(users_projects.project_id)
        if project.user_id == id
          pm_id = Department.find(project.department_id).user_id
          project.update(user_id: pm_id)
        end
      end
    end
    @users = UsersDepartment.where(user_id: id)
    UsersDepartment.destroy(@users[0].id)
    information = Information.where(user_id: id)
    information[0].update(has_department: false)
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

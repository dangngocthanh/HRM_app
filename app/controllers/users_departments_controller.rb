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
  end

  def destroy
    UsersDepartment.destroy(params[:id])
  end
end

class UserDepartmentController < ApplicationController
  def new
    @departments = Department.all
    @users = User.where(has_department: false)
  end

  def create
    if UsersDepartment.where(user_id: params['users_department']['user_id']).blank?
      @users_department = UsersDepartment.new(user_id: params['users_departments']['user_id'], department_id: params['users_department']['department_id'])
      if @users_department.save
        @user = User.find(params['user_department']['user_id'])
        @user.update(has_department: true)
      end
    end
  end

end

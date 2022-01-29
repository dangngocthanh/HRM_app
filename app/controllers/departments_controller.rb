class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
    @user = current_user
  end

  def new
    @users = User.where('role_id = 4')
    @department = Department.new
  end

  def create
    user_id = params['department']['user_id']
    @department = Department.new(name: params['department']['name'], user_id: user_id)
    if @department.save
      if add_user_department(user_id)
        if update_role_PM(user_id)
          redirect_to action: :index
        end
      end
    end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update(name: params['department']['name'])
      redirect_to action: :index
    end
  end

  def destroy
    if Department.delete(params[:id])
      redirect_to action: :index
    end
  end

  private
  def add_user_department (user_id)
    id = Department.all.order('id desc')
    id = id.limit(1)
    id = id[0].id
    @users_department = UsersDepartment.new(department_id: id, user_id: user_id)
    @users_department.save
  end

  def update_role_PM (user_id)
    @user = User.find(user_id)
    @user.update(role_id: 3)
    @user.save
  end

end

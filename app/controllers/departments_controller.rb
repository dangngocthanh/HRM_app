class DepartmentsController < ApplicationController
  # before_action :IsAdmin?, only: [:new, :create, :destroy]
  layout "dashboard"

  def index
    if policy(Department).index?
      @departments = Department.all
    else
      @departments = [current_user.department]
    end
  end

  def show
    @department = Department.find(params[:id])
    authorize @department
  end

  def new
    @users = Information.where('role_id != 2 and role_id != 1').where(has_department: false)
    @users = RoleToUser(@users)
    @department = Department.new
    authorize @department
  end

  def create
    user_id = params['department']['user_id']
    @department = Department.new(name: params['department']['name'], user_id: params['department']['user_id'])
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
    @current_PM = User.find(@department.user_id)
    authorize @department
  end

  def update
    @department = Department.find(params[:id])
    current_leader = @department.user_id
    if @department.update(name: params['department']['name'], user_id: params['department']['user_id'])
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if Department.delete(params[:id])
      redirect_to action: :index
    end
  end

  def click
    session[:department_id] = params[:id]
    redirect_to projects_path
  end

  private

  def add_user_department (user_id)
    if UsersDepartment.where(user_id: user_id).blank?
      id = Department.last
      id = id.id
      @users_department = UsersDepartment.new(department_id: id, user_id: user_id)
      @users_department.save
      return true
    else
      return true
    end
  end

  def update_role_PM(user_id)
    @user = Information.where(user_id: user_id)
    @user.update(role_id: 3)
    @user.update(has_department: true)
  end

  def return_role(current_leader)
    @role = Information.where(user_id: current_leader)
    @role.update(role_id: 4)
  end

end

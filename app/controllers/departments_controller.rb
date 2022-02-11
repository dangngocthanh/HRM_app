class DepartmentsController < ApplicationController
  # before_action :IsAdmin?, only: [:new, :create, :destroy]
  layout "dashboard"

  def index
    if current_user.information.admin? || current_user.information.hr?
      @departments = Department.all
    else
      @users_departments = UsersDepartment.where(user_id: current_user.id)
      @departments = Department.where(id: @users_departments[0].department_id)
      # if current_user.information.pm?
      # department_id = UsersDepartment.where(user_id: current_user.id)
      # department_id = department_id[0].department_id
      # @users_departments = UsersDepartment.where(department_id: department_id)
      # @users = RoleToUser(@users_departments)
      # end
      # @departments = UsersDepartment.where(user_id: current_user.id)
      # if @departments[0] != nil
      #   @department = Department.find(@departments[0].department_id)
    end
  end

  def show
    if current_user.information.admin? || current_user.information.hr?
      @department = Department.find(params[:id])
      @users_departments = UsersDepartment.where(department_id: @department.id)
      @users = RoleToUser(@users_departments)
    else
      if current_user.information.has_department
        @department = Department.find(params[:id])
        @users_departments = UsersDepartment.where(department_id: @department.id, user_id: current_user.id)
        @users = RoleToUser(@users_departments)
      end
    end
  end

  def new
    @users = Information.where('role_id != 2 and role_id != 1').where(has_department: false)
    @users = RoleToUser(@users)
    @department = Department.new
    authorize @department
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
    @current_PM = User.find(@department.user_id)
    @users_in_department = UsersDepartment.where(department_id: params[:id])
    @users = []
    @users_in_department.each do |user|
      user = Information.where(user_id: user.user_id)
      if user[0].role_id == 3
        next
      end
      @users.push(user[0])
    end
    @users_free = Information.where('role_id != 2').where(has_department: false)
    @users_free.each do |user|
      @users.push(user)
    end
    @users = RoleToUser(@users)
  end

  def update
    @department = Department.find(params[:id])
    current_leader = @department.user_id
    if @department.update(name: params['department']['name'], user_id: params['department']['user_id'])
      if add_user_department(params['department']['user_id'])
        if update_role_PM(params['department']['user_id'])
          return_role(current_leader)
          redirect_to action: :index
        end
      end
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

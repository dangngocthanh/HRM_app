class DepartmentsController < ApplicationController
  # before_action :IsAdmin?, only: [:new, :create, :destroy]
  layout "dashboard"

  def index
    if authorize Department.none
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
    @department = Department.new
    authorize @department
  end

  def create
    authorize Department.none
    @department = Department.new(name: params['department']['name'], user_id: nil)
    @department.save
    redirect_to action: :index
  end

  def edit
    @department = Department.find(params[:id])
    @current_PM = @department.project_manager
    authorize @department
  end

  def update
    authorize Department.none
    @department = Department.find(params[:id])
    if @department.update(name: params['department']['name'], user_id: params['department']['user_id'])
      redirect_to action: :index
    else
      render :edit
    end
  end

  def destroy
    authorize Department.none
    @department = Department.find(params[:id])
    UsersDepartment.delete(@department.users_departments.ids)
    @department.projects.update(department_id: nil)
    Department.destroy(params[:id])
  end

end

class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(name: params['department']['name'])
    if @department.save
      redirect_to action: :index
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

end

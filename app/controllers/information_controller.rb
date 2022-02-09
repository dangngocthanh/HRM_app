class InformationController < ApplicationController

  def edit
    @information = Information.where(user_id: current_user.id)
  end

  def update
    @information = Information.where(user_id: current_user.id)
    @information.update(params)
  end

  private

  def params
    params['information'].permit(:name, :address, :phone, :date_of_birth)
  end

end

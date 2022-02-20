class ProfilesController < ApplicationController
  layout "dashboard"
  def edit
  end

  def update
    @profile = Information.where(user_id: current_user.id)
    @profile.update(name: params['name'], address: params['address'], phone: params['phone'], date_of_birth: params['dat`e_of_birth'])
    redirect_to action: :show
  end

  def show

  end

  private


end

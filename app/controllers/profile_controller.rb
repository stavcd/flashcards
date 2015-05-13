class ProfileController < ApplicationController
  before_action :load_user, only: [:show, :update]

  def show
  end

  def update
    if (@user).update(user_params)
      flash[:notice] = 'Update user successfully'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def load_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

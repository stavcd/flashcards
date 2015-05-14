class ProfileController < ApplicationController

  def show
    @user = current_user
  end

  def update
    if (current_user).update(user_params)
      flash[:notice] = 'Update user successfully'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

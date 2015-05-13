class UsersController < ApplicationController
  skip_before_action :require_login
  before_action :load_current_user, only: [:show, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path
      flash[:notice] = 'User was successfully created'
    else
      render 'new'
    end
  end

  def show
  end

  def update
    if (@user).update(user_params)
      flash[:notice] = 'Update user successfully'
      redirect_to root_path
    else
      render 'show'
    end
  end

  private

  def load_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

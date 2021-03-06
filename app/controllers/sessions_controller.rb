class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to root_path
    else
      flash[:notice] = 'Введите правильные данные'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Выход выполнен'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end

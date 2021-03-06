class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(oauth_params[:provider])
  end

  def callback
    provider = oauth_params[:provider]
    if @user = login_from(provider)
      flash[:notice] = "Успешный вход через #{oauth_params[:provider].titleize }"
      redirect_to root_path
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path
      rescue
        redirect_to root_path, alert: 'Failed LogIn'
      end
    end
  end

  private

  def oauth_params
    params.permit(:provider, :oauth_verifier, :oauth_token)
  end
end

class UsersController < ApplicationController
  skip_before_action :login_require, only: :new
  def new
    session[:user_id] = User.line_login(params[:code])
    redirect_to root_path, notice: 'ログインしました。'
  end

  def destroy
    @current_user&.destroy
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  def show
    @user = User.find(params[:id])
  end
end

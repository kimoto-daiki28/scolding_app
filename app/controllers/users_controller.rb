class UsersController < ApplicationController
  skip_before_action :login_require, only: :new
  def new
    session[:user_id] = User.line_login(params[:code])
    redirect_to my_page_path, notice: 'ログインしました。'
  end

  def show
    @user = User.find(params[:id])
  end
end

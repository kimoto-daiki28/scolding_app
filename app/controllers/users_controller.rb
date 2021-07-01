class UsersController < ApplicationController
  def new
    session[:user_id] = User.line_login(params[:code])
    redirect_to root_path, notice: 'ログインしました'
  end
end

class ApplicationController < ActionController::Base
  before_action :login_require
  include UsersHelper

  def login_require
    redirect_to root_path, warning: 'ログインしてください。' unless current_user
  end
end

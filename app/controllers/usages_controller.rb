class UsagesController < ApplicationController
  skip_before_action :login_require, only: :index
  def index; end
end

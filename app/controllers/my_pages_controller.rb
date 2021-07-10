class MyPagesController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @wastings = @user.wastings
  end

  def edit; end
end

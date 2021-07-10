class MyPagesController < ApplicationController
  def show
    @events = current_user.wastings
  end

  def edit; end
end

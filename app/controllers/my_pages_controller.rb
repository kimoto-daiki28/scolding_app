class MyPagesController < ApplicationController
  def show
    @events = current_user.wastings
  end
end

class TermsOfServicesController < ApplicationController
  skip_before_action :login_require, only: :index
  def index; end
end

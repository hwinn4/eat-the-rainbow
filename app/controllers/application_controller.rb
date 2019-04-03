class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery prepend: true

  def login
    render 'layouts/index'
  end
end

class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  before_action :authenticate_user!
  before_action :set_current_user
  protect_from_forgery prepend: true

  def login
    render 'layouts/index'
  end

  def set_current_user
    @user = current_user
  end
end

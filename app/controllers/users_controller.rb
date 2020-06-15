class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_user!
  before_action :require_admin!

  def index
    @users = User.page(params[:page])
  end
end

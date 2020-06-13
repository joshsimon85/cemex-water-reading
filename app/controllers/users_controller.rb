class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    if params[:page]
      @users = User.page(params[:page])
    else
      @users = User.page(1)
    end
  end
end

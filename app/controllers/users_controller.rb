class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_user!
  before_action :require_admin!

  def index
    if params[:search].present?
      @users = User.where('LOWER(full_name) LIKE (?) OR LOWER(email) LIKE (?)',
                           "%#{params[:search].downcase}%",
                           "%#{params[:search].downcase}%").page(params[:page])
    else
      @users = User.page(params[:page])
    end
  end
end

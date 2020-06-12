class DeactivationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def create
    @user = find_user_by_slug

    if @user.update(suspended: true)
      flash[:success] = "#{@user.full_name}'s account has been suspended!"
      redirect_to accounts_path
    else
      flash.now[:error] = "There was an error suspending #{@user.full_name}'s account!"
      render :index
    end
  end

  def destroy
    @user = find_user_by_slug

    if @user.update(suspended: false)
      flash[:success] = "#{@user.full_name}'s account has been activated!"
      redirect_to accounts_path
    else
      flash.now[:error] = "There was an error activating #{@user.full_name}'s account!"
      render :index
    end
  end

  private

  def find_user_by_slug
    User.find_by(slug: params[:slug])
  end
end

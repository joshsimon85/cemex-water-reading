class DeactivationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def create
    @user = find_user_by_slug

    if @user.present?
      @user.update(suspended: true)
      flash[:success] = "#{capitalize_string(@user.full_name)}'s account has been suspended!"
      redirect_to accounts_path
    else
      flash[:error] = "There was an error suspending that account!"
      redirect_to accounts_path
    end
  end

  def destroy
    @user = find_user_by_slug

    if @user.present?
      @user.update(suspended: false)
      flash[:success] = "#{capitalize_string(@user.full_name)}'s account has been activated!"
      redirect_to accounts_path
    else
      flash[:error] = "There was an error activating that account!"
      redirect_to accounts_path
    end
  end

  private

  def find_user_by_slug
    User.find_by(slug: params[:slug])
  end
end

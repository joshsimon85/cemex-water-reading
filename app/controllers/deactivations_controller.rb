class DeactivationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_user!
  before_action :require_admin!, only: [:create, :destroy]

  def create
    @user = find_user_by_slug

    if @user.present?
      @user.update(suspended: true)
      Audit.create(created_by: current_user.full_name,
                   action_type: "suspension",
                   record_id: @user.slug,
                   record_type: "user: #{@user.full_name}")

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
      Audit.create(created_by: current_user.full_name,
                   action_type: "reactivation",
                   record_id: @user.slug,
                   record_type: "user: #{@user.full_name}")

      flash[:success] = "#{capitalize_string(@user.full_name)}'s account has been activated!"
      redirect_to accounts_path
    else
      flash[:error] = "There was an error activating that account!"
      redirect_to accounts_path
    end
  end

  def deactivate_own
    current_user.update(suspended: true)
    Audit.create(created_by: current_user.full_name,
                 action_type: "suspension",
                 record_id: current_user.slug,
                 record_type: "user: #{current_user.full_name}")

    flash[:success] = 'Your account has been canceled!'
    sign_out(current_user)
    redirect_to root_path
  end

  private

  def find_user_by_slug
    User.find_by(slug: params[:slug])
  end
end

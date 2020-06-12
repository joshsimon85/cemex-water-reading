class ApplicationController < ActionController::Base

  protected

  def after_sign_in_path_for(user)
    if user.admin?
      water_meter_readings_path
    else
      water_meter_reading_new_path
    end
  end

  private

  def require_admin!
    unless current_user.admin?
      flash[:error] = "You don't have permission to do that!"
      redirect_to new_water_meter_reading_path
    end
  end
end

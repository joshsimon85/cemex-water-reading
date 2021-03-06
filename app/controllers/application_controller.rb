class ApplicationController < ActionController::Base
  helper_method :capitalize_string

  def capitalize_string(name)
    name.split(' ').map(&:capitalize).join(' ')
  end

  protected

  def after_sign_in_path_for(user)
    if user.admin?
      water_meter_readings_path
    else
      new_water_meter_reading_path
    end
  end

  private

  def require_admin!
    unless current_user.admin?
      flash[:error] = "You don't have permission to do that!"
      redirect_to new_water_meter_reading_path
    end
  end

  def require_active_user!
    unless current_user.suspended == false
      flash[:error] = "Your account has been suspened, please contact an admin!"
      redirect_to root_path
    end 
  end
end

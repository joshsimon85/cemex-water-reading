class ApplicationController < ActionController::Base

  protected

  def after_sign_in_path_for(user)
       if user.admin?
         meter_readings_path
       else

       end
   end
end

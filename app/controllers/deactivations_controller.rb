class DeactivationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  
  def create

  end

  def destroy

  end
end

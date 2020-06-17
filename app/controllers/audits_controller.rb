class AuditsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_user!
  before_action :require_admin!
  
  def index
    @audits = Audit.page(params[:page])
  end
end

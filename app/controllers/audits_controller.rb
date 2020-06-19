class AuditsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_user!
  before_action :require_admin!

  def index
    if params[:search].present?
      date_parts = params['search']['created'].split('-').map(&:to_i)

      @date = Date.new(date_parts[0], date_parts[1], date_parts[2])
      @audits = Audit.where('created_at BETWEEN ? and ?',
                                           @date.beginning_of_day,
                                           @date.end_of_day).page(params[:page])
    else
      @date = Date.current
      @audits = Audit.page(params[:page])
    end
  end
end

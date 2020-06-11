class WaterMeterReadingsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      if params[:page]
        @readings = WaterMeterReading.page(params[:page])
      else
        @readings = WaterMeterReading.page(1)
      end
    else
      #@readings = WaterMeterReading.where(name is me)
    end
  end

  def show
    @reading = WaterMeterReading.find_by(slug: params[:slug])
  end
end

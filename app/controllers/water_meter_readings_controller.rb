class WaterMeterReadingsController < ApplicationController
  def index
    if params[:page]
      @readings = WaterMeterReading.page(params[:page])
    else
      @readings = WaterMeterReading.page(1)
    end  
  end
end

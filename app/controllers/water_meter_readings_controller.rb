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

  def edit
    @reading = WaterMeterReading.find_by(slug: params[:slug])
  end

  def update
    @reading = WaterMeterReading.find_by(slug: params[:slug])

    if @reading.update(reading: params[:water_meter_reading][:reading])
      flash[:success] = 'The reading has been updated.'
      redirect_to water_meter_reading_path(@reading)
    else
      flash.now[:error] = 'There was a problem updating the reading.'
      render :edit
    end
  end
end

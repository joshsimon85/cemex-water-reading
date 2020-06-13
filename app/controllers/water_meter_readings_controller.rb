class WaterMeterReadingsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!, except: [:new, :create]

  def index
    @readings = WaterMeterReading.page(params[:page])
  end

  def new

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

  def destroy
    @reading = WaterMeterReading.find_by(slug: params[:slug])

    if @reading
      @reading.destroy
      flash[:success] = 'The reading has been successfully deleted.'
      redirect_to water_meter_readings_path
    else
      flash[:error] = 'There was a problem deleting that reading.'
      redirect_to water_meter_readings_path
    end
  end
end

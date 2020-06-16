class WaterMeterReadingsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_user!
  before_action :require_admin!, except: [:new, :create]

  def index
    @readings = WaterMeterReading.page(params[:page])
  end

  def new
    @reading = WaterMeterReading.new
  end

  def create
    @reading = WaterMeterReading.create(water_meter_reading_params
                                .merge(user: current_user))
    if @reading.valid?
      flash[:success] = 'Your reading has been successfully submitted!'
      redirect_to new_water_meter_reading_path
    else
      flash.now[:error] = 'There was a problem submitting your reading!'
      render :new
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

  private

  def water_meter_reading_params
    params.require(:water_meter_reading).permit(:image, :reading)
  end
end

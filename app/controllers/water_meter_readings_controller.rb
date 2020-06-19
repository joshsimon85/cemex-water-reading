class WaterMeterReadingsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_active_user!
  before_action :require_admin!, except: [:new, :create]

  def index
    if params['readings'].present?
      @date = Date.new params['readings']['created on(1i)'].to_i,
                       params['readings']['created on(2i)'].to_i
      @readings = WaterMeterReading
                    .where('created_at BETWEEN ? and ?', @date, @date.end_of_month)
                    .page(params[:page])
    elsif params['reading'].present?
      date_parts = params['reading']['created on'].split('-').map(&:to_i)

      @date = Date.new(date_parts[0], date_parts[1], date_parts[2])
      @readings = WaterMeterReading.where('created_at BETWEEN ? and ?',
                                           @date.beginning_of_day,
                                           @date.end_of_day).page(params[:page])
    else
      @date = Date.current
      @readings = WaterMeterReading.page(params[:page])
    end
  end

  def new
    @reading = WaterMeterReading.new
  end

  def create
    @reading = WaterMeterReading.create(water_meter_reading_params
                                .merge(user: current_user))

    if @reading.valid?
      Audit.create(created_by: current_user.full_name,
                   action_type: "creation",
                   record_id: @reading.slug,
                   record_type: "water meter reading: #{@reading.reading}")

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
      Audit.create(created_by: current_user.full_name,
                   action_type: "update",
                   record_id: @reading.slug,
                   record_type: "water meter reading: #{@reading.reading}")

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
      Audit.create(created_by: current_user.full_name,
                   action_type: "deletion",
                   record_id: @reading.slug,
                   record_type: "water meter reading: #{@reading.reading}")

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

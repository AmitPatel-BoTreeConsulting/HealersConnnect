class EventSchedulesController < ApplicationController
  before_filter :event_schedule_from_params , only: [:show, :edit, :update, :destroy]
  before_filter :required_access, only: [:index, :new, :create, :edit, :update]
  def index
    @event_schedules = EventSchedule.all
  end

  def new
    @event_schedule = EventSchedule.new
  end

  def create
    params[:event_schedule][:start_date] = "#{params[:event_schedule][:start_date]} #{params[:event_schedule][:session_start]}".to_datetime
    params[:event_schedule][:end_date] = "#{params[:event_schedule][:end_date]} #{params[:event_schedule][:session_end]}".to_datetime

    remove_sessions_before_save(params[:event_schedule])
    @event_schedule = EventSchedule.new(params[:event_schedule])
    if @event_schedule.save
      event_name = @event_schedule.event.name
      flash[:notice] = t('event_schedule.message.event_schedule_created', event_schedule: event_name)
      redirect_to event_schedules_path
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    params[:event_schedule][:start_date] = "#{params[:event_schedule][:start_date]} #{params[:event_schedule][:session_start]}".to_datetime
    params[:event_schedule][:end_date] = "#{params[:event_schedule][:end_date]} #{params[:event_schedule][:session_end]}".to_datetime

    remove_sessions_before_save(params[:event_schedule])
    respond_to do |format|
      if @event_schedule.update_attributes(params[:event_schedule])
        format.html { redirect_to event_schedules_path, notice: t('event_schedule.message.event_schedule_updated', event_schedule: @event_schedule.event.name)}
      else
        format.json { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      event_name = @event_schedule.event.name
      @event_schedule.destroy
      format.html { redirect_to event_schedules_path, notice: t('event_schedule.message.event_schedule_destroy', event_schedule: event_name)}
    end
  end


  def event_schedule_from_params
    @event_schedule = EventSchedule.find(params[:id])
  end

  def remove_sessions_before_save(params)
    params.delete(:session_start)
    params.delete(:session_end)
  end
end

class EventSchedulesController < ApplicationController
  load_and_authorize_resource
  before_filter :event_schedule_from_params , only: [:show, :edit, :update, :destroy]
  def index
    @page = params[:page] || 1
    @event_schedules = EventSchedule.page(params[:page]).per(Settings.pagination.per_page).order('created_at ASC')
  end
  def new
    @event_schedule = EventSchedule.new
    unauthorized! if cannot? :new, @event_schedule
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
    @event_photo_gallery = event_photos_by_id(params[:id])
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

  def upload_photo
    @event_photo = EventPhoto.create(params[:event_photo])
    @event_photo_gallery = event_photos_by_id(params[:event_photo][:event_schedule_id])
    respond_to { |format|
      format.js {
        render file: 'event_schedules/event_photo'
      }
    }
  end

  def remove_event_photo
    respond_to do |format|
      event_photo_by_id = event_photo_from_params(params[:id])
      event_photo_name = event_photo_by_id.photo_file_name
      event_photo_by_id.destroy
      format.html { redirect_to event_schedule_path(event_photo_by_id.event_schedule_id), notice: t('event_photo_gallery.message.event_photo_destroy', event_photo: event_photo_name) }
    end
  end

  def event_schedule_from_params
    @event_schedule = EventSchedule.find(params[:id])
  end

  def remove_sessions_before_save(params)
    params.delete(:session_start)
    params.delete(:session_end)
  end

  def event_photos_by_id(event_schedule_id)
    EventPhoto.find_all_by_event_schedule_id(event_schedule_id)
  end

  def event_photo_from_params(event_photo_id)
    EventPhoto.find(event_photo_id)
  end
end

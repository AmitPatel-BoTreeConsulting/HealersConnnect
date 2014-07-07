class Website::EventsController < ApplicationController
  layout 'home'

  def index
    @page = params[:page] || 1
    if params[:up_events]
      @event_schedules = EventSchedule.upcoming_events.page(params[:page]).per(Settings.pagination.per_page).order('created_at ASC')
    elsif params[:all_events]
      @events = EventSchedule.page(params[:page]).per(Settings.pagination.per_page).order('created_at DESC')
    else
      @event_schedules = EventSchedule.upcoming_events.page(params[:page]).per(Settings.pagination.per_page).order('created_at ASC')
      @events = EventSchedule.page(params[:page]).per(Settings.pagination.per_page).order('created_at DESC')
    end
    respond_to do |format|
      format.html
      format.js {
        render file: 'website/events/index'
      }
    end
  end

  def all_events
    @page = params[:page] || 1
    @event_schedules = EventSchedule.upcoming_events.page(params[:page]).per(Settings.pagination.per_page).order('created_at ASC')
    @events = EventSchedule.page(params[:page]).per(Settings.pagination.per_page).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js {
        render file: 'website/events/index'
      }
    end
  end

  def show
    @event_schedule = EventSchedule.find(params[:id])
  end

  def show_event_image_gallery
    render :text => open(ActivityPhoto.find(params[:id]).photo.path(params[:style].to_sym), "rb").read
  end

end
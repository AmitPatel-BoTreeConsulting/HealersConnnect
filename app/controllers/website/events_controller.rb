class Website::EventsController < ApplicationController
  layout 'home'

  def index
    @page = params[:page] || 1
    if params[:up_events]
      upcoming_events
    elsif params[:all_events]
      all_events
    else
      upcoming_events
      all_events
    end
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

  private

  def upcoming_events
    @event_schedules = EventSchedule.upcoming_events.page(params[:page]).per(Settings.pagination.per_page).order('start_date ASC')
  end

  def all_events
    @events = EventSchedule.page(params[:page]).per(Settings.pagination.per_page).order('start_date DESC')
  end

end
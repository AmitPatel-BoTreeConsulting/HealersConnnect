class Website::EventsController < ApplicationController
  layout 'home'
  def show
    @event_schedule = EventSchedule.find(params[:id])
  end

  def show_event_image_gallery
    render :text => open(ActivityPhoto.find(params[:id]).photo.path(params[:style].to_sym), "rb").read
  end

  def index
  	#@page = params[:page] || 1
  	#@events  = Event.all
    #puts ("--------------------------------------#{@events.size}")
    #@page2 = params[:page2] || 1
    #@events_upcoming  = Event.page(params[:page2]).per(Settings.pagination2.per_page)
    #@events2  = Event.page(params[:page]).per(Settings.pagination.per_page)
    @event_schedule = EventSchedule.page(params[:events_schedule_page]).per(Settings.pagination.per_page).order('start_date desc')
    @events_upcoming = EventSchedule.upcoming_events.page(params[:events_upcoming_page]).per(Settings.pagination.per_page)

    respond_to do |format|
      format.js
      format.html
    end
    #puts ("---------------------------------------#{EventSchedule.upcoming_events.size}")
  end
end
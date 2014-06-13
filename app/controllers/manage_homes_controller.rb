class ManageHomesController < ApplicationController
  before_filter :upcoming_workshop_from_params, only: [ :update_upcoming_workshop ]
  before_filter :upcoming_event_from_params, only: [ :update_upcoming_event ]
  
  def index
    @upcoming_workshops = Workshop.upcoming_workshops
    @upcoming_events = EventSchedule.upcoming_events
  end

  def update_upcoming_workshop
    @upcoming_workshops = Workshop.upcoming_workshops
    update_workshop_show_on_slider(params[:status])
    respond_to do |format|
      format.json { render :json => { success: true } }
    end
  end

  def update_upcoming_event
    @upcoming_events = EventSchedule.upcoming_events
    update_event_show_on_slider(params[:status])
    respond_to do |format|
      format.json { render :json => { success: true } }
    end
  end

  private

  def upcoming_workshop_from_params
    @upcoming_workshop = Workshop.find(params[:id])
  end

  def upcoming_event_from_params
    @upcoming_event = EventSchedule.find(params[:id])
  end

  def update_workshop_show_on_slider(status)
    show_on_slider_status = status == 'true' ? true : false
    @upcoming_workshop.update_attribute(:show_on_slider, show_on_slider_status)
  end

  def update_event_show_on_slider(status)
    show_on_slider_status = status == 'true' ? true : false
    @upcoming_event.update_attribute(:show_on_slider, show_on_slider_status)
  end
end
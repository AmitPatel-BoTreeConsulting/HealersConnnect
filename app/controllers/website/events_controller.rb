class Website::EventsController < ApplicationController
  layout 'home'

  def show
    @event_schedule = EventSchedule.find(params[:id])
  end

  def show_event_image_gallery
    render :text => open(ActivityPhoto.find(params[:id]).photo.path(params[:style].to_sym), "rb").read
  end

end
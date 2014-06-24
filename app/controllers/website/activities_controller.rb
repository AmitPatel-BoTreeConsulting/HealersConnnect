class Website::ActivitiesController < ApplicationController
  before_filter :activity_from_params, only: [:show]
  layout 'home'

  def index
    @activities = Event.events_with_only_activity.order(:id)
  end

  def show
  end

  def show_activity_iamge
  end

  def show_event_image_gallery
    render :text => open(ActivityPhoto.find(params[:id]).photo.path(params[:style].to_sym), "rb").read
  end

  private

  def activity_from_params
    @activity = Event.find(params[:id])
  end
end
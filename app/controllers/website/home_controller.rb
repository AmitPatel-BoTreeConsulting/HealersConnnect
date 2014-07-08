class Website::HomeController < ApplicationController
  before_filter :event_from_params , only: [:show]
  layout 'home'
  def home
    if current_user
      render 'users/dashboard'
    else
      upcoming_event_workshop_for_slider
      @workshops = Workshop.upcoming_workshops
      @event_schedules = EventSchedule.upcoming_events.page(params[:page]).per(Settings.pagination.per_page).order('start_date ASC')

      if params[:up_events]
        respond_to do |format|
          format.html
          format.js {
            render file: 'website/events/index'
          }
        end
      end
    end
  end

  def show
  end

  private

  def upcoming_event_workshop_for_slider
    @upcoming_event_workshop_for_slider = Workshop.upcoming_workshops_for_slider + EventSchedule.upcoming_events.upcoming_events_for_slider
  end

  def event_from_params
    @event = Event.find(params[:id])
  end
end
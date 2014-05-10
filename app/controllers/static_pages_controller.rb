class StaticPagesController < ApplicationController
  before_filter :render_layout, only: [:courses, :show]
  def new_center
  end

  def registration
  end

  def home
    if current_user
      render :dashboard
    else
      upcoming_event_workshop_for_slider
      @workshops = Workshop.upcoming_workshops
      render layout: 'home'
    end
  end

  def courses
  end

  def show
  end

  private

  def upcoming_event_workshop_for_slider
    @upcoming_event_workshop_for_slider = Workshop.upcoming_workshops.upcoming_workshops_for_slider + EventSchedule.upcoming_events.upcoming_events_for_slider
  end

  def render_layout
    render layout: 'home'
  end
end

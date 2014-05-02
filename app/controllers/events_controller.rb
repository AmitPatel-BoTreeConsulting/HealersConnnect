class EventsController < ApplicationController
  before_filter :event_from_params, only: [:edit, :update, :show, :destroy]
  before_filter :set_event_category, only: [:new, :create, :edit, :update]

  def index
    @page = params[:page] || 1
    @events = deside_scope_for_event_and_activities(params[:manage_page]).page(params[:page]).per(Settings.pagination.per_page).order('created_at ASC')
  end

  def new
    @event = Event.new
    @event_categories = params[:manage_page] ? EventCategory.all : EventCategory.except_activity
  end

  def create
    @event = Event.new(params[:event])
    respond_to do |format|
      if @event.save
        flash_msg = params[:manage_page] == 'activity' ? t('activities.message.activities_created', event: @event.name) : t('event.message.event_created', event: @event.name)
        format.html { redirect_to events_path(:manage_page => params[:manage_page]), notice: flash_msg}
      else
        format.html {render :new}
      end
    end
  end

  def edit
    @event_categories = params[:manage_page] ? EventCategory.all : EventCategory.except_activity
  end

  def show
  end

  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash_msg = params[:manage_page].present? ? t('activities.message.activities_updated', event: @event.name) : t('event.message.event_created', event: @event.name)
        format.html { redirect_to events_path(:manage_page => params[:manage_page]), notice: flash_msg }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      event_name = @event.name
      @event.destroy
      flash_msg = params[:manage_page].present? ? t('activities.message.activities_destroy', event: @event.name) : t('event.message.event_created', event: @event.name)
      format.html { redirect_to events_path(:manage_page => params[:manage_page]), notice: flash_msg }
    end
  end

  private

  def set_event_category
    @event_categories = EventCategory.all
  end

  def event_from_params
    @event = Event.find(params[:id])
  end

  def deside_scope_for_event_and_activities(params)
    params ? Event.events_with_only_activity : Event.events_without_activity
  end
end

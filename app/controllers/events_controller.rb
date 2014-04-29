class EventsController < ApplicationController
  before_filter :event_from_params, only: [:edit, :update, :show, :destroy]

  def index
    @page = params[:page] || 1
    @events = Event.page(params[:page]).per(Settings.pagination.per_page).order('created_at ASC')
  end

  def new
    @event = Event.new
    @event_categories = EventCategory.all
  end

  def create
    @event = Event.new(params[:event])
    @event_categories = EventCategory.all
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: t('event.message.event_created', event: @event.name) }
      else
        format.json {render :new}
      end
    end
  end

  def edit
    @event_categories = EventCategory.all
  end

  def show
  end

  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to events_path, notice: t('event.message.event_updated', event: @event.name)}
      else
        format.json { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      event_name = @event.name
      @event.destroy
      format.html { redirect_to events_path, notice: t('event.message.event_destroy', event: event_name)}
    end
  end

  private

  def event_from_params
    @event = Event.find(params[:id])
  end

end

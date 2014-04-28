class EventsController < ApplicationController
  before_filter :event_from_params, only: [:edit, :update, :show, :destroy]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create(params)
    @event = Event.new(params[:event])
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: t('event.message.event_created', event: @event.name) }
      else
        format.json {render :new}
      end
    end
  end

  def edit
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

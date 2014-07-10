class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:show_image]
  load_and_authorize_resource except: [:show_image]

  #before_filter :event_from_params, only: [:edit, :update, :show, :destroy]
  before_filter :set_event_category, only: [:new, :create, :edit, :update]
  #before_filter :required_access, only: [:index, :create, :show, :edit, :update, :destroy]
  before_filter :set_param_for_activities, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  def index
    @page = params[:page] || 1
    @events = decide_scope_for_event_and_activities.page(params[:page]).per(Settings.pagination.per_page).order('created_at ASC')
  end

  def new
    @event = Event.new
    set_event_categories
  end

  def create
    @event = Event.new(params[:event])
    respond_to do |format|
      if @event.save
        flash_msg = params[:manage_page] == 'activity' ? t('activities.message.activities_created', event: @event.name) : t('event.message.event_created', event: @event.name)
        format.html { redirect_to events_path(:manage_page => params[:manage_page]), notice: flash_msg}
      else
        set_event_categories
        format.html {render :new}
      end
    end
  end

  def show_image
    render :text => open(Event.find(params[:id]).avatar.path(params[:style].to_sym), "rb").read
  end

  def show_event_image_gallery
    render :text => open(ActivityPhoto.find(params[:id]).photo.path(params[:style].to_sym), "rb").read
  end

  def edit
    set_event_categories
  end

  def show
    @activity_photo_gallery = activity_photos_by_id(params[:id])
  end

  def upload_photo
    @activity_photo = ActivityPhoto.create(params[:activity_photo])
    @activity_photo_gallery = activity_photos_by_id(params[:activity_photo][:event_id])
    respond_to { |format|
      format.js {
        render file: 'events/activity_photo', locals: { action_event: params[:manage_page] }
      }
    }
  end

  def remove_activity_photo
    respond_to do |format|
      activity_photo_by_id = activity_photo_from_params(params[:id])
      activity_photo_name = activity_photo_by_id.photo_file_name
      activity_photo_by_id.destroy

      format.html { redirect_to set_redirect_to_path(activity_photo_by_id.event_id), notice: t('activity_photo_gallery.message.activity_photo_destroy', activity_photo: activity_photo_name) }
    end
  end

  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash_msg = params[:manage_page].present? ? t('activities.message.activities_updated', event: @event.name) : t('event.message.event_created', event: @event.name)
        format.html { redirect_to events_path(:manage_page => params[:manage_page]), notice: flash_msg }
      else
        set_event_categories
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

  def decide_scope_for_event_and_activities
    #params[:manage_page] = 'activity' if current_user.is_super_admin? && params[:manage_page].blank?
    current_page = params[:manage_page]
    current_page ? Event.events_with_only_activity : Event.events_without_activity
  end

  def set_param_for_activities
    @activity = params[:manage_page]
  end

  def set_event_categories
    @event_categories = params[:manage_page] ? EventCategory.all : EventCategory.except_activity
  end

  def activity_photos_by_id(event_id)
    ActivityPhoto.find_all_by_event_id(event_id)
  end

  def activity_photo_from_params(activity_photo_id)
    ActivityPhoto.find(activity_photo_id)
  end

  def set_redirect_to_path(event_id)
    redirect_to_path = params[:manage_page] ? event_path(id: event_id, manage_page: 'activity') : event_path(event_id)
  end
end

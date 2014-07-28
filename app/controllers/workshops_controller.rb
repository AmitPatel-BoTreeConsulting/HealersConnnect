class WorkshopsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  #before_filter :workshop_from_params , only: [:show, :edit, :update, :destroy]
  before_filter :course_from_params, only: [:course_instructors]
  #before_filter :check_center_admin_access, only: [:edit, :update, :destroy]

  def index
    @page = params[:page] || 1
    if Registration.should_filter_by_center?(current_user)
      workshops = Workshop.filter_by_center(current_user.centers)
    else
      workshops = Workshop
    end
    @workshops =  workshops.page(params[:page]).per(Settings.pagination.per_page).order('start_date DESC')
  end

  def new
    @workshop = Workshop.new
    @instructors = Instructor.all(:order => 'name ASC')
  end

  def create
    session_date_arr = []
    params[:workshop][:workshop_sessions_attributes].each do |workshop|
      if workshop[:date].present?
        session_date_arr << workshop[:date]
        workshop[:session_start] = "#{workshop[:date]} #{workshop[:session_start]}".to_datetime
        workshop[:session_end] = "#{workshop[:date]} #{workshop[:session_end]}".to_datetime
      end
    end

    sorted_session_date_arr = session_date_arr.sort_by {|s| Date.parse s}
    if sorted_session_date_arr.present?
      params[:workshop][:start_date] =  sorted_session_date_arr.first.to_datetime
      params[:workshop][:end_date] =  sorted_session_date_arr.last.to_datetime
    end

    remove_date_before_save(params[:workshop][:workshop_sessions_attributes])
    @workshop  = Workshop.new(params[:workshop])
    @instructors = Instructor.all(:order => 'name ASC')
    respond_to do |format|
      if @workshop.save
        format.html {redirect_to workshops_path, notice: t('workshop.message.workshop_created', workshop: @workshop.course.name)}
      else
        format.html {render :new}
      end
    end
  end

  def edit
    @instructors = Instructor.order(:name)
  end

  def show
  end

  def update
    session_date_arr = []
    params[:workshop][:workshop_sessions_attributes].each do |workshop|
      if workshop[:date].present?
        session_date_arr << workshop[:date]
        workshop[:session_start] = "#{workshop[:date]} #{workshop[:session_start]}".to_datetime
        workshop[:session_end] = "#{workshop[:date]} #{workshop[:session_end]}".to_datetime
      end
    end

    sorted_session_date_arr = session_date_arr.sort_by {|s| Date.parse s}
    if sorted_session_date_arr.present?
      params[:workshop][:start_date] =  sorted_session_date_arr.first.to_datetime
      params[:workshop][:end_date] =  sorted_session_date_arr.last.to_datetime
    end

    remove_date_before_save(params[:workshop][:workshop_sessions_attributes])
    respond_to do |format|
      if @workshop.update_attributes(params[:workshop])
        format.html {redirect_to workshops_path, notice: t('workshop.message.workshop_updated', workshop: @workshop.course.name)}
      else
        @instructors = Instructor.order(:name)
        format.html {render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      @workshop.destroy
      format.html {redirect_to workshops_path, notice: t('workshop.message.workshop_destroy', workshop: @workshop.course.name)}
    end
  end

  def destroy_workshop_session
    workshop_session = WorkshopSession.find(params[:id])
    @workshop = workshop_session.workshop
    workshop_session.destroy
  end

 def course_instructors
   respond_to do |format|
     @instructors = @course.instructors
     format.js
   end
 end

  private

  def workshop_from_params
    @workshop = Workshop.find(params[:id])
  end

  def course_from_params
    @course = Course.find(params[:id])
  end

  def remove_date_before_save(workshop_attrs)
    workshop_attrs.each do |workshop_attr|
      workshop_attr.delete(:date)
    end
  end
end

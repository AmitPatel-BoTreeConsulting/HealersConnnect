class WorkshopsController < ApplicationController
  before_filter :workshop_from_params , only: [:show,:edit, :update, :destroy]
  before_filter :course_from_params, only: [:course_instructors]

  def index
    @page = params[:page] || 1
    @workshops =  Workshop.page(params[:page]).per(Settings.pagination.per_page).order('created_at ASC')
  end

  def new
    @workshop = Workshop.new
    @instructors = Instructor.all(:order => 'name ASC')
  end

  def create
    params[:workshop][:workshop_sessions_attributes].each do |workshop|
      if workshop[:date].present?
        workshop[:session_start] = "#{workshop[:date]} #{workshop[:session_start]}".to_datetime
        workshop[:session_end] = "#{workshop[:date]} #{workshop[:session_end]}".to_datetime
      end
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
    puts "^^^^^^^^^^^^^^^^^^^^^^^^#{@workshop.inspect}"
    @instructors = Instructor.all(:order => 'name ASC')
  end

  def show
  end

  def update
    params[:workshop][:workshop_sessions_attributes].each do |workshop|
      if workshop[:date].present?
        workshop[:session_start] = "#{workshop[:date]} #{workshop[:session_start]}".to_datetime
        workshop[:session_end] = "#{workshop[:date]} #{workshop[:session_end]}".to_datetime
      end
    end

    remove_date_before_save(params[:workshop][:workshop_sessions_attributes])
    respond_to do |format|
      if @workshop.update_attributes(params[:workshop])
        format.html {redirect_to workshops_path, notice: t('workshop.message.workshop_updated', workshop: @workshop.course.name)}
      else
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

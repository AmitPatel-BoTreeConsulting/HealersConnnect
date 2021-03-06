class CoursesController < ApplicationController
  before_filter :authenticate_user!, except: [:show_course_image]
  load_and_authorize_resource except: [:show_course_image]

  #before_filter :course_from_params, only: [:show, :edit, :update,:destroy, :deactivate, :activate]
  #before_filter :required_access, only: [:index, :create, :show, :edit, :update, :activate, :deactivate, :destroy]

  def index
    @page = params[:page] || 1
    @courses  = @courses.page(params[:page]).per(Settings.pagination.per_page).order('created_at ASC')
  end

  def new
    redirect_to courses_path
  end

  def create
    @course  = Course.new(params[:course])
    @course_categories  = CourseCategory.all
    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_path, notice: t('course.message.course_created', course: @course.name) }
      else
        format.html { render :new }
      end
    end
  end

  def show
  end

  def edit
    @course_categories = CourseCategory.all
  end

  def update
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to courses_path, notice: t('course.message.course_updated', course: @course.name) }
      else
        @course_categories = CourseCategory.all
        format.html { render :edit }
      end
    end
  end

  def show_course_image
    render :text => open(Course.find(params[:id]).avatar.path(params[:style].to_sym), "rb").read
  end

  def deactivate
    update_course_status(:deactivate)
  end

  def activate
    update_course_status(:activate)
  end

  def destroy
    respond_to do |format|
      course_name = @course.name
      @course.destroy
      format.html { redirect_to courses_path, notice: t('course.message.course_destroy', course: course_name) }
    end
  end

  private

  def course_from_params
    @course = Course.find(params[:id])
  end

  def update_course_status(action)
    respond_to do |format|
      status, message = case action
                        when :activate
                          [true, t('course.message.course_activate', course: @course.name)]
                        when :deactivate
                          [false, t('course.message.course_deactivate', course: @course.name)]
                        else
                        end
        @course.update_status(status)
        format.html { redirect_to courses_path, notice: message }
    end
  end

end

class Website::CoursesController < ApplicationController
  before_filter :course_from_params , only: [:detail]
  layout 'home'

  def index
    @courses = Course.find_all_by_course_category_id(CourseCategory.first.id).sort_by(&:id)
    @course = @courses.first
  end

  def category_wise_courses
    respond_to do |format|
      @courses = Course.find_all_by_course_category_id(params[:id]).sort_by(&:id)
      @course = Course.find(@courses.first)
      format.js {
          render file: 'website/courses/category_wise_courses'
      }
    end
  end

  def show
    respond_to do |format|
      @course = Course.find(params[:id])
      format.js {
        render file: 'website/courses/category_wise_courses'
      }
    end
  end

  def detail
  end

  private

  def course_from_params
    @course = Course.find(params[:id])
  end
end

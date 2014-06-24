class Website::CoursesController < ApplicationController
  layout 'home'

  def index
    workshop = Workshop.find_by_id(params[:workshop_id])
    @courses = Course.find_all_by_course_category_id(CourseCategory.first.id).sort_by(&:id)

    if workshop.present?
      @course = workshop.course
    else
      @course = @courses.first
    end
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

  def show_course_image
    render :text => open(Course.find(params[:id]).avatar.path(params[:style].to_sym), "rb").read
      format.js {
        render file: 'website/courses/category_wise_courses'
      }
  end

  private

  def course_from_params
    @course = Course.find(params[:id])
  end
end

module CoursesHelper
  def render_course_eligibility eligibility
    course_names = []
    eligibility_split = eligibility.split(',')
    eligibility_split.each do |course_alias|
      course_names << Course.find_by_alias(course_alias).name
    end
    return course_names.join(', ')
  end
end

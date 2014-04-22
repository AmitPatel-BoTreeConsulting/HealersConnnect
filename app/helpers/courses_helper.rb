module CoursesHelper
  def render_course_eligibility eligibility
    course_names = []
    eligibility_split = eligibility.split(',')
    eligibility_split.each do |eligibility_alias|
      course_names << Course.find_by_eligibility(eligibility_alias).name
    end
    return course_names.join(', ')
  end
end

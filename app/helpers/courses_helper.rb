module CoursesHelper
  def render_course_eligibility eligibility
    course_names = []
    eligibility_split = eligibility.split(',')
    eligibility_split.each do |eligibility_alias|
      if eligibility_alias == '16+'
        course_names << '16+ years'
      else
        course_names << Course.find_by_alias(eligibility_alias).name
      end
    end
    return course_names.join(', ')
  end
end

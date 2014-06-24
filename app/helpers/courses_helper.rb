module CoursesHelper
  def render_course_eligibility(aliases)
    aliases_split = aliases.split(',')
    if aliases_split.include?('16+')
      '16+ years'
    else
      Course.by_alias(aliases_split).map(&:name).join(', ')
    end
  end
end

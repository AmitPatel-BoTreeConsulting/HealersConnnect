module InstructorsHelper
  def instructor_submit_button
    if @instructor.new_record? 
      t('instructor.caption.button.save')
    else
      t('instructor.caption.button.update')
    end
  end
end

module WorkshopsHelper
  def session_start_dropdown
    select_tag("workshop[workshop_sessions_attributes][][session_start]", options_for_select(get_options_session_start_end_dropdown), :prompt=>"--Select--", class: 'col-xs-10 col-sm-5')
  end

  def session_end_dropdown
    select_tag("workshop[workshop_sessions_attributes][][session_end]", options_for_select(get_options_session_start_end_dropdown), :prompt=>"--Select--", class: 'col-xs-10 col-sm-5 margin-left-5')
  end

  def get_options_session_start_end_dropdown
    options = []
    options = ['12:00 AM', '01:00 AM', '02:00 AM', '03:00 AM', '04:00 AM', '05:00 AM', '06:00 AM', '07:00 AM', '08:00 AM', '09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '01:00 PM', '02:00 PM', '03:00 PM', '04:00 PM', '05:00 PM', '06:00 PM', '07:00 PM', '08:00 PM', '09:00 PM', '10:00 PM', '11:00 PM']
    options
  end
end

module WorkshopsHelper
  def session_start_dropdown(session_start)
    session_start_time = get_session_start_end_time(session_start)
    select_tag("workshop[workshop_sessions_attributes][][session_start]", options_for_select(get_options_session_start_end_dropdown, session_start_time), :prompt=> "09:00 AM" ,class: 'col-xs-10 col-sm-5')
  end

  def session_end_dropdown(session_end)
    session_end_time = get_session_start_end_time(session_end)
    select_tag("workshop[workshop_sessions_attributes][][session_end]", options_for_select(get_options_session_start_end_dropdown, session_end_time), :prompt=> "07:00 PM" , class: 'col-xs-10 col-sm-5 margin-left-5')
  end

  def get_options_session_start_end_dropdown
    ['12:00 AM', '01:00 AM', '02:00 AM', '03:00 AM', '04:00 AM', '05:00 AM', '06:00 AM', '07:00 AM', '08:00 AM', '09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '01:00 PM', '02:00 PM', '03:00 PM', '04:00 PM', '05:00 PM', '06:00 PM', '07:00 PM', '08:00 PM', '09:00 PM', '10:00 PM', '11:00 PM']
  end

  def get_session_start_end_time(session_start_end_time)
    session_start_end_time.strftime("%I:%M %p") if session_start_end_time.present?
  end

  def fees_date
    if @workshop.fees_date.present?
      date_formatted(@workshop.fees_date)
    else
      ''
    end
  end
end

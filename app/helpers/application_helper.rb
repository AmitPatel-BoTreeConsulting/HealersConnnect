module ApplicationHelper

  def display_style(show)
    "display:#{show ? 'block' : 'none'}"
  end

  def active_menu(menu)
    active_menu = active_current_page?(menu.to_s, HealersConnectConstant::COMMON_CONTROLLER_ACTIONS)
    'active' if active_menu
  end

  def active_current_page?(controller, action = nil, src = nil)
    if src == params[:src]
      return true if params[:controller] == controller && (!action || action_present?(action))
    end
    false
  end

  def action_present?(action)
    if action.is_a?(Hash) && action.key?(:except)
      !action[:except].include?(params[:action])
    else
      action.include?(params[:action])
    end
  end

  def render_navigation_menu_option(option)
    case option
    when :donations
      url = donations_path
      link_title = t('navbar.menu.title.donations')

    when :centers
      url = centers_path
      link_title = t('navbar.menu.title.centers')

    when :instructors
      url = instructors_path
      link_title = t('navbar.menu.title.instructors')

    when :courses
      url = courses_path
      link_title = t('navbar.menu.title.courses')
    when :workshops
      url = workshops_path
      link_title = t('navbar.menu.title.workshops')
    when :events
      url = events_path
      link_title = t('navbar.menu.title.events')

    when :event_schedules
      url = event_schedules_path
      link_title = t('navbar.menu.title.event_schedules')

    when :activities
      url = events_path(manage_page: 'activity')
      link_title = t('navbar.menu.title.activities')
    else
    end
    content_tag(:li, link_to(link_title, url),
                class: active_menu(option)) if current_user.has_permission?(option)

  end

  def render_css_class(name)
    css_class = ''
    msg_icon_class = ''
    case name
    when :error, :redirect_error
      css_class = 'alert-danger'
      msg_icon_class = 'icon-remove'
    when :notice, :redirect_notice
      css_class = 'alert-success'
      msg_icon_class = 'icon-ok'
    when :alert
      css_class = 'alert-danger'
      msg_icon_class = 'icon-remove'
    else
    end
    {css_class: css_class, msg_icon_class: msg_icon_class}
  end

  def date_formatted(date)
    date.try(:strftime, '%d/%m/%Y')
  end

  def serial_number(page, index)
    (page.to_i - 1) * Settings.pagination.per_page + index + 1
  end

  def gender_formatted(gender)
    return unless gender
    gender == 'M' ? t('registration.caption.male') : t('registration.caption.female')
  end

  def marital_status_formatted(married)
    married ? t('registration.caption.marital_status_married') : t('registration.caption.marital_status_unmarried')
  end
end

module ApplicationHelper

  def display_style(show)
    "display:#{show ? 'block' : 'none'}"
  end

  def active_menu(menu)
    active_menu =
      case menu
      when :donations
        active_current_page?('donations', HealersConnectConstant::COMMON_CONTROLLER_ACTIONS)
      when :registrations
        active_current_page?('registrations', HealersConnectConstant::COMMON_CONTROLLER_ACTIONS)
      when :centers
        active_current_page?('centers', HealersConnectConstant::COMMON_CONTROLLER_ACTIONS)
      when :courses
        active_current_page?('courses', HealersConnectConstant::COMMON_CONTROLLER_ACTIONS)
      when :instructors
        active_current_page?('instructors',HealersConnectConstant:: COMMON_CONTROLLER_ACTIONS)
      when :workshops
        active_current_page?('workshops',HealersConnectConstant:: COMMON_CONTROLLER_ACTIONS)
      else
        false
      end
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
end

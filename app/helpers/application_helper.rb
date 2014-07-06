module ApplicationHelper

  def display_style(show)
    "display:#{show ? 'block' : 'none'}"
  end

  def active_menu(menu, other_attr)
    active_menu = active_current_page?(menu.to_s, HealersConnectConstant::COMMON_CONTROLLER_ACTIONS, other_attr)
    'active' if active_menu
  end

  def active_current_page?(controller, action = nil, src = nil, other_attr)
    if (controller == 'activities' || controller == 'events') && other_attr && (!action || action_present?(action))
      return controller == 'activities'

    elsif src == params[:src]
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

  def render_navigation_menu_option(option, other_attr)
    if can?(:read, Workshop) && option == :workshops
      url = workshops_path
      link_title = t('navbar.menu.title.workshops')
    elsif can?(:manage, Donation) && option == :donations
      url = donations_path
      link_title = t('navbar.menu.title.donations')
    elsif can?(:manage, Event) && option == :events
      url = events_path
      link_title = t('navbar.menu.title.events')
    elsif can?(:manage, EventSchedule) && option == :event_schedules
      url = event_schedules_path
      link_title = t('navbar.menu.title.event_schedules')
    elsif current_user.is_super_admin? && option == :activities
      url = events_path(manage_page: 'activity')
      link_title = t('navbar.menu.title.activities')
    elsif can?(:manage, Center) && option == :centers
      url = centers_path
      link_title = t('navbar.menu.title.centers')
    elsif can?(:manage, Course) && option == :courses
      url = courses_path
      link_title = t('navbar.menu.title.courses')
    elsif can?(:manage, Instructor) && option == :instructors
      url = instructors_path
      link_title = t('navbar.menu.title.instructors')
    elsif (Role::SUPER_ADMIN) && option == :manage_homes
      url = manage_homes_path
      link_title = t('navbar.menu.title.manage_homes')
    end

    if url
      content_tag(:li, link_to(link_title, url), class: active_menu(option, other_attr))
    end
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

  def date_time_formatted(date)
    date.try(:strftime, '%d/%m/%Y %I:%M %p')
  end

  def time_formatted(date)
    date.try(:strftime, '%I:%M %p')
  end
end

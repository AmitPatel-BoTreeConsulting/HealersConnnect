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

end

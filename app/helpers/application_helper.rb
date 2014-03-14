module ApplicationHelper
  def display_style(show)
    "display:#{show ? 'block' : 'none'}"
  end
end

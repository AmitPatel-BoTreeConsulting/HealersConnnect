module DonationsHelper
  DONATION_TIMELINES = %w(weekly monthly yearly)
  def received_by_dropdown(donations, selected)
    options = donations.collect do |donation|
        [donation.user.email, donation.user.id]
    end
    select_tag("donation[user_id][]", options_for_select(options.uniq, selected[:user_id]), multiple: 'true', style: "display: none;", id: 'form-field-select-4', class: 'width-30 chosen-select donation_search_fields')
  end

  def active_donation_pill(timeline=nil)
    css_class = ''
    filter_timeline = params[:timeline]
    if timeline.present? && filter_timeline.present? && filter_timeline == timeline
      css_class = 'active'
    elsif timeline.blank? && filter_timeline.present? && !DONATION_TIMELINES.include?(filter_timeline)
      css_class = 'active'
    elsif timeline.blank? && filter_timeline.blank?
      css_class = 'active'
    end
    css_class
  end
end
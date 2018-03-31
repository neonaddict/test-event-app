module EventsHelper
  require 'icalendar'

  def ics_create(ics_event)
    filename = "#{ics_event.name}.ics"
    # Create a calendar with an event (standard method)
    cal = Icalendar::Calendar.new
    cal.event do |e|
      e.dtstart     = ics_event.date
      e.dtend       = ics_event.date
      e.summary     = ics_event.name
      e.description = ics_event.description
      e.location    = "#{ics_event.city}, #{ics_event.address}"
    end
    send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment',
      filename: filename
  end
end

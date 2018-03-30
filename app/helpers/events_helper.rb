module EventsHelper
    require 'icalendar'

    def ics_create(ev)
        filename = "#{ev.name}.ics"
        # Create a calendar with an event (standard method)
        cal = Icalendar::Calendar.new
        cal.event do |e|
          e.dtstart     = ev.date
          e.dtend       = ev.date
          e.summary     = ev.name
          e.description = ev.description
          e.location    = "#{ev.city}, #{ev.address}"
        end
        send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
    end
end

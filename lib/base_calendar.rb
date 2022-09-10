class BaseCalendar
  # @param title [String]
  def initialize(title)
    @title = title
  end

  private

  def to_calendar(events)
    cal = Icalendar::Calendar.new

    cal.append_custom_property("X-WR-CALNAME;VALUE=TEXT", @title)

    events.each do |event|
      cal.event do |e|
        e.dtstamp     = nil
        e.uid         = event["url"]
        e.summary     = event["title"]
        e.description = event["url"]

        if event["started_at"] && !event["started_at"].empty?
          e.dtstart = to_ical_datetime(event["started_at"])
        end

        if event["ended_at"] && !event["ended_at"].empty?
          e.dtend = to_ical_datetime(event["ended_at"])
        end
      end
    end

    cal.publish
    cal.to_ical
  end

  def to_ical_datetime(str)
    Icalendar::Values::DateTime.new(Time.parse(str).utc)
  end
end

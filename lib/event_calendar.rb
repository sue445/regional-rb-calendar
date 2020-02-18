class EventCalendar
  # @param site [String]
  # @param title [String]
  def initialize(site:, title:)
    @site   = site
    @title  = title
  end

  # @param groups [Array<Hash>]
  def generate_ical(groups)
    events = fetch_all_events(groups)

    events.sort_by! do |event|
      [event["started_at"], event["ended_at"], event["url"]]
    end

    to_calendar(events)
  end

  private

  def fetch_all_events(groups)
    events = Parallel.map(groups, in_threads: 5) do |group|
      res = JSON.parse(URI.open("https://condo3.appspot.com/api/#{@site}/#{group["id"]}.json").read)
      res["events"]
    end
    events.flatten
  end

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

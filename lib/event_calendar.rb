class EventCalendar
  # @param site [String]
  # @param title [String]
  def initialize(site:, title:)
    @site  = site
    @title = title
  end

  # @param groups [Array<Hash>]
  def generate_ical_from_condo3(groups)
    events = fetch_all_events_from_condo3(groups)

    events.sort_by! do |event|
      [event["started_at"], event["ended_at"], event["url"]]
    end

    to_calendar(events)
  end

  # @param groups [Array<Hash>]
  # @param current_date [Date]
  def generate_ical_from_connpass(groups, current_date)
    events = fetch_all_events_from_connpass(groups, current_date)

    events.sort_by! do |event|
      [event["started_at"], event["ended_at"], event["url"]]
    end

    to_calendar(events)
  end

  # @param current_date [Date]
  # @return [Array<Integer>]
  def self.connpass_terms(current_date)
    current_month = Date.new(current_date.year, current_date.month, 1)
    start_month = current_month.prev_month(3)
    end_month = current_month.next_month(3)

    terms = []
    temp_month = start_month
    while temp_month <= end_month do
      terms << temp_month.year * 100 + temp_month.month
      temp_month = temp_month.next_month
    end
    terms
  end

  private

  def fetch_all_events_from_condo3(groups)
    events = Parallel.map(groups, in_threads: 5) do |group|
      res = JSON.parse(URI.open("https://condo3.appspot.com/api/#{@site}/#{group["id"]}.json").read)
      res["events"]
    end
    events.flatten
  end

  def fetch_all_events_from_connpass(groups, current_date)
    series_ids = groups.map { |group| group["series_id"] }
    res = Connpass.event_search(series_id: series_ids.join(","), ym: EventCalendar.connpass_terms(current_date).join(","), count: 100, order: 1)

    res.events.map do |event|
      {
        "url"        => event.event_url,
        "title"      => event.title,
        "started_at" => event.started_at,
        "ended_at"   => event.ended_at,
      }
    end
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

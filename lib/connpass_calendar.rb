require_relative "base_calendar"

class ConnpassCalendar < BaseCalendar
  def initialize
    super("connpassの地域.rb")
  end

  # @param groups [Array<Hash>]
  # @param current_date [Date]
  def generate_ical(groups, current_date)
    events = fetch_all_events(groups, current_date)

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

  def fetch_all_events(groups, current_date)
    series_ids = groups.map { |group| group["series_id"] }.join(",")
    ym = ConnpassCalendar.connpass_terms(current_date).join(",")
    res = Connpass.event_search(series_id: series_ids, ym: ym, count: 100, order: 1)

    res.events.map do |event|
      {
        "url"        => event.event_url,
        "title"      => event.title,
        "started_at" => event.started_at,
        "ended_at"   => event.ended_at,
      }
    end
  end
end

require_relative "base_calendar"

class ConnpassCalendar < BaseCalendar
  MAX_COUNT = 100

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
    ids = groups.map { |group| group["id"] }.join(",")
    ym = ConnpassCalendar.connpass_terms(current_date).join(",")

    client = ConnpassApiV2.client(ENV["CONNPASS_API_KEY"])

    start = 1
    events = []
    loop do
      res = client.get_events(subdomain: ids, ym: ym, count: MAX_COUNT, start: start)
      events << res.events

      if res.events.count < MAX_COUNT
        break
      else
        start += MAX_COUNT

        # for API throttling
        # c.f. https://connpass.com/about/api/v2/#section/%E6%A6%82%E8%A6%81/%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E5%88%B6%E9%99%90
        sleep 1
      end
    end

    events.flatten.map do |event|
      {
        "url"        => event.url,
        "title"      => event.title,
        "started_at" => event.started_at,
        "ended_at"   => event.ended_at,
      }
    end
  end
end

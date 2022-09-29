require_relative "base_calendar"

class DoorkeeperCalendar < BaseCalendar
  def initialize
    super("Doorkeeperの地域.rb")
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

  private

  def fetch_all_events(groups, current_date)
    events = Parallel.map(groups, in_threads: 5) do |group|
      fetch_doorkeeper_events(group, current_date)
    end
    events.flatten
  end

  def fetch_doorkeeper_events(group, current_date)
    since_date = current_date << 6
    until_date = current_date >> 6

    client = DoorkeeperJp.client(ENV["DOORKEEPER_ACCESS_TOKEN"])
    events = client.group_events(group["id"], sort: "published_at", since_date: since_date, until_date: until_date)
    events.map do |event|
      {
        "url" => event.public_url,
        "title" => event.title,
        "started_at" => event.starts_at,
        "ended_at" => event.ends_at,
      }
    end
  end
end

require_relative "base_calendar"

class DoorkeeperCalendar < BaseCalendar
  def initialize
    super("Doorkeeperの地域.rb")
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
      res = JSON.parse(URI.open("https://condo3.appspot.com/api/doorkeeper/#{group["id"]}.json").read)
      res["events"]
    end
    events.flatten
  end
end

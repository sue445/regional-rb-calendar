ENV["RACK_ENV"] ||= "development"
Bundler.require(:default, ENV["RACK_ENV"])

require "open-uri"
require "yaml"

class App < Sinatra::Base
  configure do
    mime_type :ics, "text/calendar"
  end

  get "/" do
    "It works"
  end

  get "/api/calendar/:site.ics" do
    content_type :ics

    config_file = File.join(__dir__, "config", "#{params[:site]}.yml")
    halt 404 unless File.exists?(config_file)

    config = YAML.load_file(config_file)[ENV["RACK_ENV"]]

    events = fetch_all_events(params[:site], config["groups"])

    events.sort_by! do |event|
      [event["started_at"], event["ended_at"], event["url"]]
    end

    to_calendar(config["title"], events)
  end

  helpers do
    def fetch_all_events(site, groups)
      events = Parallel.map(groups, in_threads: 5) do |group|
        res = JSON.parse(URI.open("https://condo3.appspot.com/api/#{site}/#{group}.json").read)
        res["events"]
      end
      events.flatten
    end

    def to_calendar(title, events)
      cal = Icalendar::Calendar.new

      cal.append_custom_property("X-WR-CALNAME;VALUE=TEXT", title)

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
      Icalendar::Values::DateTime.new(Time.parse(str))
    end
  end
end

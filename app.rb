ENV["RACK_ENV"] ||= "development"
Bundler.require(:default, ENV["RACK_ENV"])

require "open-uri"
require "json"

require_relative "./lib/connpass_calendar"
require_relative "./lib/doorkeeper_calendar"

Sentry.init do |config|
  config.dsn = ENV["SENTRY_DSN"]
end

class App < Sinatra::Base
  use Sentry::Rack::CaptureExceptions

  configure do
    mime_type :ics, "text/calendar"
  end

  get "/" do
    "It works"
  end

  get "/api/calendar/connpass.ics" do
    content_type :ics
    groups = config_groups("connpass")
    ConnpassCalendar.new.generate_ical(groups, Date.today)
  end

  get "/api/calendar/doorkeeper.ics" do
    content_type :ics
    groups = config_groups("doorkeeper")
    DoorkeeperCalendar.new.generate_ical(groups, Date.today)
  end

  helpers do
    def config_groups(site)
      config_file = File.join(__dir__, "docs", "config", "#{site}.json")
      config = JSON.parse(File.read(config_file))
      config["groups"]
    end
  end
end

FunctionsFramework.http("regional-rb-calendar") do |request|
  App.call(request.env)
end

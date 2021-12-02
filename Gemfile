# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.0.3"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "connpass", ">= 0.1.0"
gem "icalendar"
gem "parallel"
gem "puma", require: false
gem "sentry-ruby"
gem "sinatra"

group :development do
  gem "foreman", require: false
end

group :test do
  gem "rack-test"
  gem "rspec"
  gem "rspec-its", require: "rspec/its"
  gem "webmock", require: "webmock/rspec"
end

# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.7.3"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "connpass"
gem "google-cloud-secret_manager"
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

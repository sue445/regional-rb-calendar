# frozen_string_literal: true

source "https://rubygems.org"

# c.f. https://cloud.google.com/functions/docs/concepts/ruby-runtime
ruby "~> 3.0.0"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "connpass", ">= 0.1.0"
gem "functions_framework"
gem "icalendar"
gem "parallel"
gem "sentry-ruby"
gem "sinatra"

group :test do
  gem "rack-test"
  gem "rspec"
  gem "rspec-its", require: "rspec/its"
  gem "webmock", require: "webmock/rspec"
end

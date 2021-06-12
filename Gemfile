# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "connpass"
gem "icalendar"
gem "parallel"
gem "puma", require: false
gem "sinatra"

group :test do
  gem "rack-test"
  gem "rspec"
  gem "rspec-its", require: "rspec/its"
  gem "webmock", require: "webmock/rspec"
end

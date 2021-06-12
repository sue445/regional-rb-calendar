# regional-rb-calendar
地域.rbの開催情報を集めたカレンダーです

https://sue445.github.io/regional-rb-calendar/

[![CircleCI](https://circleci.com/gh/sue445/regional-rb-calendar/tree/master.svg?style=svg)](https://circleci.com/gh/sue445/regional-rb-calendar/tree/master)

## グループの追加方法
[docs/config/connpass.json](docs/config/connpass.json) か [docs/config/doorkeeper.json](docs/config/doorkeeper.json) に `id` と `name` を追加するだけ

## Development
```bash
bundle config --local path "vendor/bundle"
bundle install

bundle exec foreman s

curl http://localhost:9292/api/calendar/connpass.ics
curl http://localhost:9292/api/calendar/doorkeeper.ics
```

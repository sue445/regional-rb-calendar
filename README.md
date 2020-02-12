# regional-rb-calendar
地域.rbの開催情報を集めたカレンダーです

https://sue445.github.io/regional-rb-calendar/

[![CircleCI](https://circleci.com/gh/sue445/regional-rb-calendar/tree/master.svg?style=svg)](https://circleci.com/gh/sue445/regional-rb-calendar/tree/master)

## グループの追加方法
1. [config/connpass.yml](config/connpass.yml) か [config/doorkeeper.yml](config/doorkeeper.yml) の `groups` にIDを追加
2. [docs/index.html](docs/index.html) にグループ名を追加

## Development
```bash
bundle config --local path "vendor/bundle"
bundle install

bundle exec rackup -s Puma

curl http://localhost:9292/api/calendar/connpass.ics
curl http://localhost:9292/api/calendar/doorkeeper.ics
```

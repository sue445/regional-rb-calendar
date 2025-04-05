# regional-rb-calendar
地域.rbの開催情報を集めたカレンダーです

https://sue445.github.io/regional-rb-calendar/

[![build](https://github.com/sue445/regional-rb-calendar/actions/workflows/build.yml/badge.svg)](https://github.com/sue445/regional-rb-calendar/actions/workflows/build.yml)

## グループの追加方法
[docs/config/connpass.json](docs/config/connpass.json) か [docs/config/doorkeeper.json](docs/config/doorkeeper.json) に `id` と `name` を追加するだけ

## Development
```bash
bundle config --local path "vendor/bundle"
bundle install

bundle exec functions-framework-ruby --target regional-rb-calendar

curl http://localhost:8080/api/calendar/doorkeeper.ics
```

Connpass API v2の利用にはAPI keyが必要なので、ローカル環境などでは `/api/calendar/connpass.ics` が呼び出せなくなっています。

ref. https://connpass.com/about/api/v2/#section/%E6%A6%82%E8%A6%81/API

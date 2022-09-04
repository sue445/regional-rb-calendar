# regional-rb-calendar
地域.rbの開催情報を集めたカレンダーです

https://sue445.github.io/regional-rb-calendar/

[![build](https://github.com/sue445/regional-rb-calendar/actions/workflows/build.yml/badge.svg)](https://github.com/sue445/regional-rb-calendar/actions/workflows/build.yml)

## グループの追加方法
[docs/config/connpass.json](docs/config/connpass.json) か [docs/config/doorkeeper.json](docs/config/doorkeeper.json) に `id` と `name` と `series_id` （connpassのみ） を追加するだけ

`series_id` は下記のようなコマンドで調べてください。（下記の例だと `series_id` は `2338` ）

```bash
$ curl -s https://fukuokarb.connpass.com/ | grep "https://connpass.com/series/"
          <input type="hidden" name="next" value="https://connpass.com/series/2538/?gmem=1" />
```

## Development
```bash
bundle config --local path "vendor/bundle"
bundle install

bundle exec foreman s

curl http://localhost:9292/api/calendar/connpass.ics
curl http://localhost:9292/api/calendar/doorkeeper.ics
```

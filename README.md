# regional-rb-calendar
地域.rbの開催情報を集めたカレンダーです

https://sue445.github.io/regional-rb-calendar/

[![build](https://github.com/sue445/regional-rb-calendar/actions/workflows/build.yml/badge.svg)](https://github.com/sue445/regional-rb-calendar/actions/workflows/build.yml)

> [!WARNING]
> Connpass APIの仕様変更により、2024年5月23日(木)以降Connpassのイベント情報がカレンダーで更新されなくなります
> c.f. https://github.com/sue445/regional-rb-calendar/issues/254

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

bundle exec functions-framework-ruby --target regional-rb-calendar

curl http://localhost:8080/api/calendar/connpass.ics
curl http://localhost:8080/api/calendar/doorkeeper.ics
```

def sentry_dsn
  ENV["SENTRY_DSN"]
end

Sentry.init do |config|
  config.dsn = sentry_dsn
end

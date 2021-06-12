require "google/cloud/secret_manager"

def fetch_secret_manager_value(secret_name)
  client = Google::Cloud::SecretManager.secret_manager_service
  response = client.access_secret_version(name: secret_name)
  response.payload.data
end

def sentry_dsn
  return fetch_secret_manager_value(ENV["SECRET_KEY_SENTRY_DSN"]) if ENV["SECRET_KEY_SENTRY_DSN"]

  ENV["SENTRY_DSN"]
end

Sentry.init do |config|
  config.dsn = sentry_dsn
end

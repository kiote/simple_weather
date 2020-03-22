# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :simple_weather, SimpleWeatherWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KPguM2soRp3cOYa+sjHMDYrizo5ostabyxSK/AQc/u4jNSHh3mCrFtmInNXRvplI",
  render_errors: [view: SimpleWeatherWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: SimpleWeather.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "9rGIXRLp"]

config :simple_weather,
  darkskyx_adapter: SimpleWeather.DarkSkyxAdapter,
  darkskyx_connector: Darkskyx,
  machine_readable_presenter: SimpleWeather.DarkSkyxPresenter,
  location: {59.4716181, 24.5981613}

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :darkskyx,
  api_key: System.get_env("DARKSKY_API_KEY"),
  defaults: [
    units: "us",
    lang: "en"
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :simple_weather, SimpleWeatherWeb.Endpoint,
  http: [port: 4002],
  server: false

config :simple_weather,
  darkskyx_adapter: SimpleWeather.DarkskyxAdapterMock,
  darkskyx_connector: SimpleWeather.DarkskyxMock

# Print only warnings and errors during test
config :logger, level: :warn

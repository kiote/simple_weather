defmodule SimpleWeather.Utils.WeatherTimeBehaviour do
  @callback now() :: integer()
  @callback to_hours(integer()) :: integer()
end

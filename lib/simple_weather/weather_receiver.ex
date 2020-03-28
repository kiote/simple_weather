defmodule SimpleWeather.WeatherReceiver do
  require Logger

  alias SimpleWeather.AdaptersFactory
  alias SimpleWeather.Cache

  def weather_adapter do
    AdaptersFactory.darkskyx()
  end

  def today do
    weather_adapter().params_for_today()
    |> Cache.maybe_get_from(weather_adapter(), &weather_adapter().today/0)
  end

  def yesterday do
    weather_adapter().params_for_time_machine(:yesterday)
    |> Cache.maybe_get_from(weather_adapter(), &weather_adapter().time_machine/1, :yesterday)
  end

  def the_day_before_yesterday do
    weather_adapter().params_for_time_machine(:the_day_before_yesterday)
    |> Cache.maybe_get_from(
      weather_adapter(),
      &weather_adapter().time_machine/1,
      :the_day_before_yesterday
    )
  end

  def two_days_before_yesterday do
    weather_adapter().params_for_time_machine(:two_days_before_yesterday)
    |> Cache.maybe_get_from(
      weather_adapter(),
      &weather_adapter().time_machine/1,
      :two_days_before_yesterday
    )
  end
end

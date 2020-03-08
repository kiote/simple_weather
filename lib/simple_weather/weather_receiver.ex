defmodule SimpleWeather.WeatherReceiver do
  alias SimpleWeather.AdaptersFactory
  alias SimpleWeather.Utils.EtsCache

  def weather_adapter do
    AdaptersFactory.darkskyx()
  end

  def today do
    weather_adapter().params_for_today()
    |> maybe_get_from_cache()
  end

  defp maybe_get_from_cache(%{lat: lat, long: long}) do
    EtsCache.get("#{lat}#{long}")
  end
end

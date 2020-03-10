defmodule SimpleWeather.WeatherReceiver do
  alias SimpleWeather.AdaptersFactory
  alias SimpleWeather.Utils.EtsCache

  @ttl 60 * 10 * 1000 # 10 min

  def weather_adapter do
    AdaptersFactory.darkskyx()
  end

  def today do
    weather_adapter().params_for_today()
    |> maybe_get_from_cache()
  end

  defp maybe_get_from_cache(%{lat: lat, long: long}) do
    key = "#{lat}#{long}"
    case EtsCache.get(key) do
      nil ->
        res = weather_adapter().today()
        EtsCache.put({key, res, @ttl})
        res
      val ->
        val
    end
  end
end

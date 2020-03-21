defmodule SimpleWeather.WeatherReceiver do
  alias SimpleWeather.AdaptersFactory
  alias SimpleWeather.Utils.EtsCache

  # 10 min
  @ttl 60 * 10 * 1000

  def weather_adapter do
    AdaptersFactory.darkskyx()
  end

  def today do
    weather_adapter().params_for_today()
    |> maybe_get_from_cache()
  end

  def yesterday do
    weather_adapter().params_for_time_machine(:yesterday)
    |> maybe_get_from_cache
  end

  def the_day_before_yesterday do
    weather_adapter().params_for_time_machine(:the_day_before_yesterday)
    |> maybe_get_from_cache
  end

  def two_days_before_yesterday do
    weather_adapter().params_for_time_machine(:two_days_before_yesterday)
    |> maybe_get_from_cache
  end

  def time_machine(day \\ :yesterday) do
    weather_adapter().params_for_time_machine(day)
    |> maybe_get_from_cache
  end

  defp maybe_get_from_cache(params) do
    key = weather_adapter().get_cache_key(params)

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

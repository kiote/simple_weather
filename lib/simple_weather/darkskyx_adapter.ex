defmodule SimpleWeather.DarkSkyxAdapter do
  @behaviour SimpleWeather.AdapterBehaviour

  @tallinn {59.4716181, 24.5981613}
  @forecast_defaults %Darkskyx{exclude: "daily,minutely", units: "auto"}
  @ttl_sec 60 * 60

  alias SimpleWeather.Utils.CommonCache

  @impl SimpleWeather.AdapterBehaviour
  def today() do
    {lat, long} = @tallinn
    maybe_get_from_cache(lat, long)
  end

  defp maybe_get_from_cache(lat, long) do
    case CommonCache.get("#{lat}#{long}") do
      nil ->
        res = Darkskyx.forecast(lat, long, @forecast_defaults)
        CommonCache.put("#{lat}#{long}", res, @ttl_sec)
        res

      %{ttl: _ttl, value: value} ->
        value
    end
  end
end

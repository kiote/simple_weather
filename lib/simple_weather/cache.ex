defmodule SimpleWeather.Cache do
  
  alias SimpleWeather.Utils.EtsCache
  # 10 min
  @ttl 60 * 10 * 1000
  
  def maybe_get_from(key_params, weather_adapter, func) do
    key = weather_adapter.get_cache_key(key_params)

    case EtsCache.get(key) do
      nil ->
        res = func.()
        EtsCache.put({key, res, @ttl})
        res

      val ->
        val
    end
  end

  def maybe_get_from(key_params, weather_adapter, func, params) do
    key = weather_adapter.get_cache_key(key_params)

    case EtsCache.get(key) do
      nil ->
        res = func.(params)
        EtsCache.put({key, res, @ttl})
        res

      val ->
        val
    end
  end

end

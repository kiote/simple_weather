defmodule SimpleWeather.CacheTest do
  use ExUnit.Case, async: true

  import Mox

  alias SimpleWeather.WeatherReceiver
  alias SimpleWeather.Cache

  test "maybe_get_from/4" do
    SimpleWeather.DarkskyxAdapterMock
    |> expect(:params_for_today, fn -> %{lat: "1", long: "2"} end)
    |> expect(:get_cache_key, fn _ -> "12" end)
    |> expect(:time_machine, fn _ -> "res" end)

    weather_adapter = WeatherReceiver.weather_adapter()
    key_params = weather_adapter.params_for_today()

    assert Cache.maybe_get_from(
             key_params,
             weather_adapter,
             &weather_adapter.time_machine/1,
             :yesterday
           ) == "res"
  end
end

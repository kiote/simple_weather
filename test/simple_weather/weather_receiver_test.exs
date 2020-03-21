defmodule SimpleWeather.WeatherReceiverTest do
  use ExUnit.Case, async: true

  import Mox

  setup do
    verify_on_exit!()
    SimpleWeather.Utils.EtsCache.clear()
    :ok
  end

  alias SimpleWeather.WeatherReceiver

  describe "today/0" do
    test "invokes" do
      SimpleWeather.DarkSkyxAdapterMock
      |> expect(:params_for_today, fn -> %{lat: 1.1, long: 1.1} end)
      |> expect(:get_cache_key, fn _ -> "" end)
      |> expect(:today, fn -> %{} end)

      assert WeatherReceiver.today() == %{}
    end

    test "caches results" do
      SimpleWeather.DarkSkyxAdapterMock
      |> expect(:params_for_today, 2, fn -> %{lat: 1.1, long: 1.1} end)
      |> expect(:get_cache_key, 2, fn _ -> "" end)
      |> expect(:today, 1, fn -> %{} end)

      assert WeatherReceiver.today() == %{}
      assert WeatherReceiver.today() == %{}
    end
  end

  describe "time_machine/1" do
    test "invokes" do
      SimpleWeather.DarkSkyxAdapterMock
      |> expect(:params_for_time_machine, fn _ -> %{lat: 1.1, long: 1.1, timestamp: 12} end)
      |> expect(:get_cache_key, fn _ -> "" end)
      |> expect(:today, fn -> %{} end)

      assert WeatherReceiver.time_machine() == %{}
    end
  end
end

defmodule SimpleWeather.WeatherReceiverTest do
  use ExUnit.Case, async: true

  import Mox

  alias SimpleWeather.WeatherReceiver

  describe "today/0" do
    test "invokes" do
      SimpleWeather.DarkSkyxAdapterMock
      |> expect(:params_for_today, fn -> %{lat: 1.1, long: 1.1} end)
      |> expect(:today, fn -> %{} end)

      assert WeatherReceiver.today() == %{}
    end

    test "caches results" do
      SimpleWeather.DarkSkyxAdapterMock
      |> expect(:params_for_today, 2, fn -> %{lat: 1.1, long: 1.1} end)
      |> expect(:today, 1, fn -> %{} end)

      assert WeatherReceiver.today() == %{}
      assert WeatherReceiver.today() == %{}
    end
  end

  describe "time_machine/1" do
    test "invokes" do
    end
  end
end

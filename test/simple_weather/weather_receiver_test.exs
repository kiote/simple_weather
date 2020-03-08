defmodule SimpleWeather.WeatherReceiverTest do
  use ExUnit.Case, async: true

  import Mox

  alias SimpleWeather.WeatherReceiver

  test "today" do
    SimpleWeather.DarkSkyxAdapterMock
    |> expect(:params_for_today, fn -> %{lat: 1.1, long: 1.1} end)

    WeatherReceiver.today()
  end
end

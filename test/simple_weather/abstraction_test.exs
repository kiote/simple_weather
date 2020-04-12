defmodule SimpleWeather.AbstractionTest do
  use ExUnit.Case, async: true

  import Mox
  import Support.MockedForecast

  alias SimpleWeather.Abstraction

  setup :verify_on_exit!

  test "today" do
    forecast = mocked_forecast()

    SimpleWeather.DarkskyxMock
    |> expect(:forecast, fn _, _, _ -> {:ok, forecast, "headers"} end)

    SimpleWeather.Utils.WeatherTimeMock
    |> expect(:now, fn -> 1_577_840_400 end)
    |> expect(:to_hours, fn _ -> 2 end)

    impl = SimpleWeather.DarkSkyxAdapter
    assert Abstraction.today(impl) == "hi"
  end
end

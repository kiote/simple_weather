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

    impl = SimpleWeather.DarkSkyxAdapter
    assert Abstraction.today(impl) == "hi"
  end
end

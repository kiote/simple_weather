defmodule SimpleWeather.AbstractionTest do
  use ExUnit.Case, async: true

  import Mox
  import Support.MockedForecast

  alias SimpleWeather.Abstraction
  alias SimpleWeather.Utils.EtsCache

  setup do
    :verify_on_exit!
    EtsCache.clear()
    %{forecast: mocked_forecast(), impl: SimpleWeather.DarkSkyxAdapter}
  end

  describe "today/0" do
    test "returns correct hours till sunset", %{forecast: forecast, impl: impl} do
      SimpleWeather.DarkskyxMock
      |> expect(:forecast, fn _, _, _ -> {:ok, forecast, "headers"} end)

      SimpleWeather.Utils.WeatherTimeMock
      |> expect(:now, fn -> 1_577_840_400 end)
      |> expect(:to_hours, fn _ -> 2 end)

      assert %{hours_till_dark: -2} = Abstraction.today(impl)
    end

    test "returns correct data for morning", %{forecast: forecast, impl: impl} do
      SimpleWeather.DarkskyxMock
      |> expect(:forecast, fn _, _, _ -> {:ok, forecast, "headers"} end)

      SimpleWeather.Utils.WeatherTimeMock
      |> expect(:now, fn -> 1_577_840_400 end)
      |> expect(:to_hours, fn _ -> 2 end)

      assert %{weather: %{precipitation_probability: 0.1, temperature: 5.76, wind: 4.23}} =
               Abstraction.today(impl)
    end

    test "returns correct data for evening", %{forecast: forecast, impl: impl} do
      SimpleWeather.DarkskyxMock
      |> expect(:forecast, fn _, _, _ -> {:ok, forecast, "headers"} end)

      SimpleWeather.Utils.WeatherTimeMock
      |> expect(:now, fn -> 1_577_840_400 end)
      |> expect(:to_hours, fn _ -> 2 end)

      assert %{weather: %{precipitation_probability: 0.1, temperature: 5.76, wind: 4.23}} =
               Abstraction.today(impl)
    end
  end
end

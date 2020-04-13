defmodule SimpleWeather.AbstractionTest do
  use ExUnit.Case, async: true

  import Mox
  import Support.MockedForecast

  alias SimpleWeather.Abstraction

  setup do
    :verify_on_exit!
    %{forecast: mocked_forecast(), impl: SimpleWeather.DarkSkyxAdapter}
  end

  describe "today/0" do
    test "returns correct hours till sunset", %{forecast: forecast, impl: impl} do
      SimpleWeather.DarkskyxMock
      |> expect(:forecast, fn _, _, _ -> {:ok, forecast, "headers"} end)

      SimpleWeather.Utils.WeatherTimeMock
      |> expect(:now, fn -> 1_577_840_400 end)
      |> expect(:to_hours, fn _ -> 2 end)

      assert %{till_dark: 2} = Abstraction.today(impl)
    end

    test "returns correct data for morning", %{forecast: forecast, impl: impl} do
      SimpleWeather.DarkskyxMock
      |> expect(:forecast, fn _, _, _ -> {:ok, forecast, "headers"} end)

      SimpleWeather.Utils.WeatherTimeMock
      |> expect(:now, fn -> 1_577_840_400 end)
      |> expect(:to_hours, fn _ -> 2 end)

      assert %{morning: %{precipitation_probability: 0.1, temperature: 65.76, wind: 4.23}} =
               Abstraction.today(impl)
    end

    test "returns correct data for evening", %{forecast: forecast, impl: impl} do
      SimpleWeather.DarkskyxMock
      |> expect(:forecast, fn _, _, _ -> {:ok, forecast, "headers"} end)

      SimpleWeather.Utils.WeatherTimeMock
      |> expect(:now, fn -> 1_577_840_400 end)
      |> expect(:to_hours, fn _ -> 2 end)

      assert %{evening: %{precipitation_probability: 0.1, temperature: 65.76, wind: 4.23}} =
               Abstraction.today(impl)
    end
  end
end

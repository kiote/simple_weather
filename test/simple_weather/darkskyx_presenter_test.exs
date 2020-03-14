defmodule Darkskyx.PresenterTest do
  use ExUnit.Case, async: true

  describe "convert/1" do
    test "when it's less than +5 degrees" do
      val = %{
        "currently" => %{
          "apparentTemperature" => -6.49,
          "cloudCover" => 0.48,
          "dewPoint" => -8.14,
          "humidity" => 0.56,
          "icon" => "partly-cloudy-night",
          "ozone" => 446.7,
          "precipAccumulation" => 0.0093,
          "precipIntensity" => 0.009,
          "precipProbability" => 0.02,
          "precipType" => "snow",
          "pressure" => 1019,
          "summary" => "Partly Cloudy",
          "temperature" => -0.42,
          "time" => 1_584_215_710,
          "uvIndex" => 0,
          "visibility" => 16.093,
          "windBearing" => 326,
          "windGust" => 9.09,
          "windSpeed" => 7.09
        }
      }

      assert SimpleWeather.DarkSkyxPresenter.convert(val) == "600000"
    end
  end
end

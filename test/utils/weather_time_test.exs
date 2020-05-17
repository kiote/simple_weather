defmodule SimpleWeather.Utils.WeatherTimeTest do
  use ExUnit.Case, async: true

  alias SimpleWeather.Utils.WeatherTime

  test "now" do
    assert WeatherTime.now() == Timex.now() |> Timex.to_unix()
  end

  test "to_hours/1" do
    assert 2.0 == WeatherTime.to_hours(7200)
  end
end

defmodule SimpleWeather.LocationTest do
  use ExUnit.Case, async: true

  alias SimpleWeather.Location

  test "lat_long_location" do
    assert Location.lat_long_location() == {59.4716181, 24.5981613}
  end
end

defmodule SimpleWeather.Location do
  @moduledoc """
  Location service
  """  

  def lat_long_location do
    Application.get_env(:simple_weather, :location)
  end
end

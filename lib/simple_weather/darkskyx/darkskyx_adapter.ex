defmodule SimpleWeather.DarkSkyxAdapter do
  @behaviour SimpleWeather.AdapterBehaviour

  alias SimpleWeather.TimeMachine
  alias SimpleWeather.Location

  @forecast_defaults %Darkskyx{exclude: "daily,minutely", units: "auto"}
  @time_machine_defaults %Darkskyx{exclude: "hourly", units: "auto"}

  @impl SimpleWeather.AdapterBehaviour
  def params_for_today() do
    {lat, long} = Location.lat_long_location
    %{lat: lat, long: long, defaults: @forecast_defaults}
  end

  @impl SimpleWeather.AdapterBehaviour
  def today() do
    %{lat: lat, long: long, defaults: defaults} = params_for_today()
    Darkskyx.forecast(lat, long, defaults)
  end

  def params_for_time_machine(day \\ :today) do
    {lat, long} = Location.lat_long_location
    timestamp = TimeMachine.get_time_stamp(day)
    %{lat: lat, long: long, timestamp: timestamp, defaults: @time_machine_defaults}
  end

  @impl SimpleWeather.AdapterBehaviour
  def time_machine(day \\ :yesterday) do
    %{lat: lat, long: long, timestamp: timestamp, defaults: defaults} =
      params_for_time_machine(day)

    Darkskyx.time_machine(lat, long, timestamp, defaults)
  end
end

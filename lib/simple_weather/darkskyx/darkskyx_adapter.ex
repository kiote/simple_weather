defmodule SimpleWeather.DarkSkyxAdapter do
  @behaviour SimpleWeather.AdapterBehaviour

  require Logger

  alias SimpleWeather.TimeMachine
  alias SimpleWeather.Location
  alias SimpleWeather.Darkskyx.ParamsForToday
  alias SimpleWeather.Darkskyx.ParamsForTimeMachine
  alias SimpleWeather.Utils.EtsCache, as: Cache

  defp get_connector, do: Application.get_env(:simple_weather, :darkskyx_connector)

  @forecast_defaults %Darkskyx{exclude: "minutely", units: "auto"}
  @time_machine_defaults %Darkskyx{exclude: "hourly", units: "auto"}
  # hour cache
  @caches_for 60_000 * 60

  def formater do
    SimpleWeather.Darkskyx.Formater
  end

  @impl true
  def params_for_today() do
    {lat, long} = Location.lat_long_location()
    %ParamsForToday{lat: lat, long: long, defaults: @forecast_defaults}
  end

  @impl true
  def today() do
    %{lat: lat, long: long, defaults: defaults} = params_for_today()

    key = params_for_today()
          |> get_cache_key()

    key
    |> maybe_get_from_cache()
    |> case do
      nil ->
        case get_connector().forecast(lat, long, defaults) do
          {:ok, today, _headers} ->
            result = today
                     |> Utils.StringsToAtoms.convert()

            Cache.put({key, result, @caches_for})
            result

          error ->
            Logger.error("Unexpected response from weather service: #{inspect(error)}")
            nil
        end

      result ->
        result
    end
  end

  @impl true
  def params_for_time_machine(day \\ :yesterday) do
    {lat, long} = Location.lat_long_location()
    timestamp = TimeMachine.get_time_stamp(day)

    %ParamsForTimeMachine{
      lat: lat,
      long: long,
      timestamp: timestamp,
      defaults: @time_machine_defaults
    }
  end

  @impl true
  def time_machine(day \\ :yesterday) do
    %{lat: lat, long: long, timestamp: timestamp, defaults: defaults} =
      params_for_time_machine(day)

    get_connector().time_machine(lat, long, timestamp, defaults)
  end

  @impl true
  def get_cache_key(%ParamsForToday{lat: lat, long: long}) do
    "#{lat}#{long}"
  end

  @impl true
  def get_cache_key(%ParamsForTimeMachine{lat: lat, long: long, timestamp: timestamp}) do
    "#{lat}#{long}#{timestamp}"
  end

  defp maybe_get_from_cache(key) do
    Cache.get(key)
  end
end

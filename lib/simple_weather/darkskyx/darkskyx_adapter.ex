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
    params_for_today()
    |> get_from_cache()
    |> ensure_result()
    |> convert_strings_to_atoms()
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

  defp get_from_cache(params) do
    params
    |> get_cache_key()
    |> Cache.get()
  end

  defp ensure_result(nil) do
    get_forecast()
    |> put_to_cache()
  end

  defp ensure_result(result), do: result

  defp get_forecast() do
    %{lat: lat, long: long, defaults: defaults} = params_for_today()
    get_connector().forecast(lat, long, defaults)
  end

  defp put_to_cache({:ok, today, _headers}) do
    key = get_cache_key(params_for_today())

    Cache.put({key, today, @caches_for})
    today
  end

  defp put_to_cache(params) do
    Logger.error("put_to_cache called with unexpected params: #{inspect(params)}")
    nil
  end

  defp convert_strings_to_atoms(nil), do: nil

  defp convert_strings_to_atoms(val) do
    Utils.StringsToAtoms.convert(val)
  end
end

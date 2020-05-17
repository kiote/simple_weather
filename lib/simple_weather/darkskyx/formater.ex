defmodule SimpleWeather.Darkskyx.Formater do
  require Logger

  alias SimpleWeather.Types.Condition

  defp weather_time, do: Application.get_env(:simple_weather, :weather_time)

  def get_till_dark_from_now(%{daily: %{data: []}}) do
    Logger.error("Unexpected: empty daily data")
  end

  def get_till_dark_from_now(forecast) do
    weather_time().now()
    |> deduct_sunset_time(forecast)
    |> weather_time().to_hours()
    |> change_sign()
  end

  def get_weather_condition(%{hourly: %{data: data}} = forecast) do
    sunset_time = sunset_time(forecast)

    before_dusk = filter_dark_hours(data, sunset_time)

    %Condition{
      precipitation_intensity: max_before_dusk(:precipIntensity, before_dusk),
      precipitation_probability: max_before_dusk(:precipProbability, before_dusk),
      wind: max_before_dusk(:windSpeed, before_dusk),
      temperature: min_before_dusk(:temperature, before_dusk)
    }
  end

  defp max_before_dusk(val, before_dusk) do
    get_list_before_dusk(val, before_dusk)
    |> Enum.max()
  end

  defp min_before_dusk(val, before_dusk) do
    get_list_before_dusk(val, before_dusk)
    |> Enum.min()
  end

  defp get_list_before_dusk(val, before_dusk) do
    before_dusk
    |> get_list_of(val)
  end

  defp sunset_time(%{daily: %{data: [%{sunsetTime: sunset_time} | _]}}), do: sunset_time

  defp deduct_sunset_time(timestamp, forecast), do: timestamp - sunset_time(forecast)

  defp change_sign(x), do: -x

  defp filter_dark_hours(d, sunset_time), do: Enum.filter(d, fn %{time: t} -> t < sunset_time end)

  defp get_list_of(d, key) do
    Enum.map(d, fn %{^key => p} -> p end)
  end
end

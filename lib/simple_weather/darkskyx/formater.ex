defmodule SimpleWeather.Darkskyx.Formater do
  require Logger

  alias SimpleWeather.Types.Condition

  defp weather_time, do: Application.get_env(:simple_weather, :weather_time)

  def get_till_dark_from_now(%{daily: %{data: []}}) do
    Logger.error("Unexpected: empty daily data")
  end

  def get_till_dark_from_now(forecast) do
    weather_time().now()
    |> Kernel.-(sunset_time(forecast))
    |> weather_time().to_hours()
    |> Kernel.abs()
  end

  # %{temperature: t1, precipProbability: p1, windSpeed: w1, time: tm1},
  # %{temperature: t2, precipProbability: p2, windSpeed: w2, time: tm2},
  # %{temperature: t3, precipProbability: p3, windSpeed: w3, time: tm3} | _

  def get_weather_condition(%{hourly: %{data: data}} = forecast) do
    sunset_time = sunset_time(forecast)

    before_dusk =
      data
      |> Enum.filter(fn %{time: t} -> t < sunset_time end)

    %Condition{
      precipitation_probability:
        Enum.max(Enum.map(before_dusk, fn %{precipProbability: p} -> p end)),
      wind: Enum.max(Enum.map(before_dusk, fn %{windSpeed: w} -> w end)),
      temperature: Enum.max(Enum.map(before_dusk, fn %{temperature: t} -> t end))
    }
  end

  defp sunset_time(%{daily: %{data: [%{sunsetTime: sunset_time} | _]}}), do: sunset_time
end

defmodule SimpleWeather.Abstraction do
  require Logger

  alias SimpleWeather.Types.Condition
  alias SimpleWeather.Types.ShortCondition
  alias SimpleWeather.Types.Today

  @spec today(any()) :: %Today{morning: %Condition{}, evening: %Condition{}, till_dark: integer()}
  def today(implementation) do
    {:ok, today, _headers} = implementation.today()
    till_dark = get_till_dark_from_now(today)
    morning = get_morning_condition(today)
    evening = get_evening_condition(today)
    %Today{morning: morning, evening: evening, till_dark: till_dark}
  end

  @spec days_ago(days: non_neg_integer(), implementation: any()) :: %ShortCondition{}
  def days_ago(days: _days, implementation: implementation) do
    implementation.time_machine()
  end

  #
  # private
  #

  defp weather_time, do: Application.get_env(:simple_weather, :weather_time)

  defp get_till_dark_from_now(%{daily: %{data: []}}) do
    Logger.error("Unexpected: empty daily data")
  end

  defp get_till_dark_from_now(%{daily: %{data: [%{sunsetTime: sunset_time} | _]}}) do
    weather_time().now()
    |> Kernel.-(sunset_time)
    |> weather_time().to_hours()
  end

  defp get_morning_condition(%{
         hourly: %{
           data: [
             %{temperature: t1, precipProbability: p1, windSpeed: w1, time: tm1},
             %{temperature: t2, precipProbability: p2, windSpeed: w2, time: tm2},
             %{temperature: t3, precipProbability: p3, windSpeed: w3, time: tm3} | _
           ]
         }
       }) do
    Logger.info(
      morning: [
        %{temp: t1, prec: p1, wind: w1, time: tm1},
        %{temp: t2, prec: p2, wind: w2, time: tm2},
        %{temp: t3, prec: p3, wind: w3, time: tm3}
      ]
    )

    %Condition{
      precipitation_probability: Enum.max([p1, p2, p3]),
      wind: Enum.max([w1, w2, w3]),
      temperature: Enum.max([t1, t2, t3])
    }
  end

  defp get_evening_condition()
end

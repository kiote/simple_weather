defmodule SimpleWeather.Darkskyx.Formater do
  require Logger

  alias SimpleWeather.Types.Condition

  defp weather_time, do: Application.get_env(:simple_weather, :weather_time)

  def get_till_dark_from_now(%{daily: %{data: []}}) do
    Logger.error("Unexpected: empty daily data")
  end

  def get_till_dark_from_now(%{daily: %{data: [%{sunsetTime: sunset_time} | _]}}) do
    weather_time().now()
    |> Kernel.-(sunset_time)
    |> weather_time().to_hours()
  end

  def get_morning_condition(%{
        hourly: %{
          data: [
            # 8-10am
            # 0am
            _,
            # 1am
            _,
            # 2am
            _,
            _,
            _,
            # 6am
            _,
            # 7am
            _,
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

  def get_evening_condition(%{
        hourly: %{
          data: [
            # 4-7pm
            # 0am
            _,
            _,
            _,
            _,
            # 4am
            _,
            _,
            _,
            _,
            # 8am
            _,
            _,
            _,
            _,
            # 12pm
            _,
            _,
            _,
            # 3pm
            _,
            %{temperature: t1, precipProbability: p1, windSpeed: w1, time: tm1},
            %{temperature: t2, precipProbability: p2, windSpeed: w2, time: tm2},
            %{temperature: t3, precipProbability: p3, windSpeed: w3, time: tm3},
            %{temperature: t4, precipProbability: p4, windSpeed: w4, time: tm4}
            | _
          ]
        }
      }) do
    Logger.info(
      evening: [
        %{temp: t1, prec: p1, wind: w1, time: tm1},
        %{temp: t2, prec: p2, wind: w2, time: tm2},
        %{temp: t3, prec: p3, wind: w3, time: tm3},
        %{temp: t4, prec: p4, wind: w4, time: tm4}
      ]
    )

    %Condition{
      precipitation_probability: Enum.max([p1, p2, p3, p4]),
      wind: Enum.max([w1, w2, w3, w4]),
      temperature: Enum.max([t1, t2, t3, t4])
    }
  end
end

defmodule SimpleWeather.DarkSkyxPresenter do
  require Logger
  alias SimpleWeather.TimeMachine

  @temperature_threshold 4
  @probability_threshold 0.5
  @negative_impact 2
  @positive_impact 0
  @two_hours 2*60*60

  def convert(
        %{
          "currently" => %{"temperature" => t, "precipProbability" => p},
          "daily" => %{"data" => [%{"sunsetTime" => s} | _]}
        },
        :now
      ) do
    Logger.info(
      "Now: #{inspect(%{temp: t, precip: p, sunset: s, now: Timex.now() |> Timex.to_unix()})}"
    )

    convert_to_presentable(%{temperature: t, precip_probability: p, sunset: s})
  end

  def convert(%{"hourly" => %{"data" => hourly_forecast}}, :two_hours_from_now) do
    Enum.reduce(hourly_forecast, "", &for_two_hours_from_now/2)
  end

  def convert(%{"hourly" => %{"data" => hourly_forecast}}, :seven_hours_from_now) do
    Enum.reduce(hourly_forecast, "", &for_seven_hours_from_now/2)
  end

  # private

  defp for_two_hours_from_now(%{"time" => time, "temperature" => t, "precipProbability" => p}, "") do
    {shifted_time, prev_hour} = TimeMachine.shifted_time(2)

    if time >= prev_hour && time <= shifted_time do
      Logger.info("Two hours from now: #{inspect(%{temperature: t, precip: p})}")

      convert_to_presentable(%{temperature: t, precip_probability: p})
    else
      ""
    end
  end

  defp for_two_hours_from_now(_val, acc) do
    acc
  end

  defp convert_to_presentable(%{temperature: t, precip_probability: p, sunset: s}) do
    temperature(t)
    |> Kernel.+(precip_probability(p))
    |> Kernel.+(sunset(s))
    |> to_string()
  end

  defp convert_to_presentable(%{temperature: t, precip_probability: p}) do
    temperature(t)
    |> Kernel.+(precip_probability(p))
    |> to_string()
  end


  defp for_seven_hours_from_now(
         %{"time" => time, "temperature" => t, "precipProbability" => p},
         ""
       ) do
    {shifted_time, prev_hour} = TimeMachine.shifted_time(7)

    if time >= prev_hour && time <= shifted_time do
      Logger.info("Seven hours from now: #{inspect(%{temperature: t, percip: p})}")

      convert_to_presentable(%{temperature: t, precip_probability: p})
    else
      ""
    end
  end

  defp for_seven_hours_from_now(%{}, acc), do: acc

  defp temperature(t) when t <= @temperature_threshold do
    @negative_impact
  end

  defp temperature(_), do: @positive_impact

  defp precip_probability(p) when p <= @probability_threshold do
    @positive_impact
  end

  defp precip_probability(_), do: @negative_impact

  defp sunset(s) do
    now = Timex.now() |> Timex.to_unix()
    if s - @two_hours > now do
      @negative_impact
    else
      @positive_impact
    end
  end
end

defmodule SimpleWeather.DarkSkyxPresenter do
  require Logger
  alias SimpleWeather.TimeMachine

  @threshold 4
  @temperature_negative_impact "6"
  @temperature_positive_impact "0"

  def convert(%{"currently" => %{"temperature" => t}}, :now) do
    temperature(t)
  end

  def convert(%{"hourly" => %{"data" => hourly_forecast}}, :two_hours_from_now) do
    Enum.reduce(hourly_forecast, "", &for_two_hours_from_now/2)
  end

  def convert(%{"hourly" => %{"data" => hourly_forecast}}, :seven_hours_from_now) do
    Enum.reduce(hourly_forecast, "", &for_seven_hours_from_now/2)
  end

  defp for_two_hours_from_now(%{"time" => time, "temperature" => t}, "") do
    {shifted_time, prev_hour} = TimeMachine.shifted_time(2)

    if time >= prev_hour && time <= shifted_time do
      Logger.info("Two hours from now: #{inspect(%{temperature: t, time: time})}")

      temperature(t)
    else
      ""
    end
  end

  defp for_two_hours_from_now(_val, acc) do
    acc
  end

  defp for_seven_hours_from_now(%{"time" => time, "temperature" => t}, "") do
    {shifted_time, prev_hour} = TimeMachine.shifted_time(7)

    if time >= prev_hour && time <= shifted_time do
      Logger.info("Two hours from now: #{inspect(%{temperature: t, time: time})}")

      temperature(t)
    else
      ""
    end
  end

  defp for_seven_hours_from_now(%{}, acc), do: acc

  defp temperature(t) when t <= @threshold do
    @temperature_negative_impact
  end

  defp temperature(_), do: @temperature_positive_impact
end

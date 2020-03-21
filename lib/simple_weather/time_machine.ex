defmodule SimpleWeather.TimeMachine do
  @moduledoc """
  Time operations for weather providers
  """
  @day_start_hour 8

  def get_time_stamp(:yesterday) do
    Timex.shift(day_start(), days: -1) |> to_unix() |> Kernel.+(to_day_start())
  end

  def get_time_stamp(:the_day_before_yesterday) do
    Timex.shift(day_start(), days: -2) |> to_unix() |> Kernel.+(to_day_start())
  end

  def get_time_stamp(:two_days_before_yesterday) do
    Timex.shift(day_start(), days: -3) |> to_unix() |> Kernel.+(to_day_start())
  end

  defp day_start() do
    Timex.now() |> Timex.beginning_of_day()
  end

  defp to_unix(timestamp) do
    timestamp |> Timex.to_unix()
  end

  defp to_day_start() do
    to_seconds(@day_start_hour)
  end

  defp to_seconds(val) when is_integer(val) do
    val * 60 * 60
  end
end

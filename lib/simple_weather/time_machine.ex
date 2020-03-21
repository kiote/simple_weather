defmodule SimpleWeather.TimeMachine do
  @moduledoc """
  Time operations for weather providers
  """
  @one_day_hours 24
  @day_start_hour 8

  def get_time_stamp(:yesterday) do
    day_start_unix() - to_seconds(@one_day_hours) + to_day_start()
  end

  def get_time_stamp(:the_day_before_yesterday) do
    day_start_unix() - to_seconds(2 * @one_day_hours) + to_day_start()
  end

  def get_time_stamp(:two_days_before_yesterday) do
    day_start_unix() - to_seconds(3 * @one_day_hours) + to_day_start()
  end

  defp day_start_unix() do
    Timex.now() |> Timex.beginning_of_day() |> Timex.to_unix()
  end

  defp to_day_start() do
    to_seconds(@day_start_hour)
  end

  defp to_seconds(val) when is_integer(val) do
    val * 60 * 60
  end
end

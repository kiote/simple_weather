defmodule SimpleWeather.TimeMachine do
  @moduledoc """
  Time operations for weather providers
  """
  @one_day_hours 24
  @day_start_hour 8

  def get_time_stamp(:yesterday) do
    day_start_unix() - 60 * 60 * @one_day_hours + to_day_start()
  end

  def day_start_unix() do
    Timex.now() |> Timex.beginning_of_day() |> Timex.to_unix()
  end

  def to_day_start() do
    @day_start_hour * 60 * 60
  end
end

defmodule SimpleWeather.Abstraction do
  require Logger

  alias SimpleWeather.Types.Condition
  alias SimpleWeather.Types.ShortCondition
  alias SimpleWeather.Types.Today

  @spec today(any()) :: %Today{morning: %Condition{}, evening: %Condition{}, till_dark: integer()}
  def today(implementation) do
    {:ok, today, _headers} = implementation.today()
    _till_dark = get_till_dark_from(today)
  end

  @spec days_ago(days: non_neg_integer(), implementation: any()) :: %ShortCondition{}
  def days_ago(days: _days, implementation: implementation) do
    implementation.time_machine()
  end

  # private

  defp get_till_dark_from(%{daily: %{data: []}}) do
    Logger.error("Unexpected: empty daily data")
  end

  defp get_till_dark_from(%{daily: %{data: [%{sunsetTime: sunset_time} | _]}}) do
    sunset_time
  end
end

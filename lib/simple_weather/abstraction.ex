defmodule SimpleWeather.Abstraction do
  alias SimpleWeather.Types.Condition
  alias SimpleWeather.Types.ShortCondition
  alias SimpleWeather.Types.Today

  @spec today(any()) :: %Today{morning: %Condition{}, evening: %Condition{}, till_dark: integer()}
  def today(implementation) do
    {:ok, today, headers} = implementation.today()
    till_dark = get_till_dark_from(today)
  end

  @spec days_ago(days: non_neg_integer(), implementation: any()) :: %ShortCondition{}
  def days_ago(days: _days, implementation: implementation) do
    implementation.time_machine()
  end

  # private

  defp get_till_dark_from(today) do
  end
end

defmodule SimpleWeather.Abstraction do
  alias SimpleWeather.Types.Condition
  alias SimpleWeather.Types.ShortCondition
  alias SimpleWeather.Types.Today

  @spec today(any()) :: %Today{morning: %Condition{}, evening: %Condition{}, till_dark: integer()}
  def today(implementation) do
    implementation.today()
  end

  @spec days_ago(days: non_neg_integer(), implementation: any()) :: %ShortCondition{}
  def days_ago(days: _days, implementation: implementation) do
    implementation.time_machine()
  end
end

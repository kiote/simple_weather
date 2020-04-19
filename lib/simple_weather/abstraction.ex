defmodule SimpleWeather.Abstraction do
  require Logger

  alias SimpleWeather.Types.Condition
  alias SimpleWeather.Types.ShortCondition
  alias SimpleWeather.Types.Today

  @spec today(any()) :: %Today{morning: %Condition{}, evening: %Condition{}, till_dark: integer()}
  def today(implementation) do
    with today <- implementation.today(),
         formater <- implementation.formater(),
         till_dark <- formater.get_till_dark_from_now(today),
         morning <- formater.get_morning_condition(today),
         evening <- formater.get_evening_condition(today) do
Logger.info(inspect(today))
      %Today{morning: morning, evening: evening, till_dark: till_dark}
    end
  end

  @spec days_ago(days: non_neg_integer(), implementation: any()) :: %ShortCondition{}
  def days_ago(days: _days, implementation: implementation) do
    implementation.time_machine()
  end
end

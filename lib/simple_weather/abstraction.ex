defmodule SimpleWeather.Abstraction do
  require Logger

  alias SimpleWeather.Types.Condition
  alias SimpleWeather.Types.ShortCondition
  alias SimpleWeather.Types.Today

  @spec today(any()) :: %Today{weather: %Condition{}, hours_till_dark: float()}
  def today(implementation) do
    with today <- implementation.today(),
         formater <- implementation.formater(),
         till_dark <- formater.get_till_dark_from_now(today),
         weather <- formater.get_weather_condition(today) do
      %Today{weather: weather, hours_till_dark: till_dark}
    end
  end

  @spec days_ago(days: non_neg_integer(), implementation: any()) :: %ShortCondition{}
  def days_ago(days: _days, implementation: implementation) do
    implementation.time_machine()
  end
end

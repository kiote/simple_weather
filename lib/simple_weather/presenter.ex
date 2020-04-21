defmodule SimpleWeather.Presenter do
  require Logger

  alias SimpleWeather.Types.Condition
  alias SimpleWeather.Types.Today

  @precipitation_probability_threshold 0.7
  @temperature_threshold 5
  @till_dark_threshold -2
  @wind_threshold 10

  def to_machine(%Today{
        morning: %Condition{
          temperature: temperature_morning,
          wind: wind_morning,
          precipitation_probability: precipitation_probability_morning
        },
        evening: %Condition{
          temperature: temperature_evening,
          wind: wind_evening,
          precipitation_probability: precipitation_probability_evening
        },
        till_dark: till_dark
      })
      when temperature_morning < @temperature_threshold or
             temperature_evening < @temperature_threshold or
             wind_morning > @wind_threshold or
             wind_evening > @wind_threshold or
             precipitation_probability_evening > @precipitation_probability_threshold or
             precipitation_probability_morning > @precipitation_probability_threshold or
             till_dark > @till_dark_threshold,
      do: "NO"

  def to_machine(%Today{
        morning: %Condition{
          temperature: temperature_morning,
          wind: wind_morning,
          precipitation_probability: precipitation_probability_morning
        },
        evening: %Condition{
          temperature: temperature_evening,
          wind: wind_evening,
          precipitation_probability: precipitation_probability_evening
        },
        till_dark: till_dark
      })
      when temperature_morning >= @temperature_threshold and
             temperature_evening >= @temperature_threshold and wind_morning <= @wind_threshold and
             wind_evening <= @wind_threshold and
             precipitation_probability_evening <= @precipitation_probability_threshold and
             precipitation_probability_morning <= @precipitation_probability_threshold and
             till_dark <= @till_dark_threshold,
      do: "YES"

  def to_machine(anything) do
    Logger.error("#{inspect(anything)} is not expected value for to_machine/1")
    "ERROR"
  end
end

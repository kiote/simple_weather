defmodule SimpleWeather.Presenter do
  require Logger

  alias SimpleWeather.Types.Condition
  alias SimpleWeather.Types.Today

  @precipitation_probability_threshold 0.7
  @temperature_threshold 5
  @till_dark_threshold 2
  @wind_threshold 10

  def to_machine(%Today{
        weather: %Condition{
          temperature: temperature,
          wind: wind,
          precipitation_probability: precipitation_probability
        },
        hours_till_dark: till_dark
      })
      when temperature < @temperature_threshold or
             wind > @wind_threshold or
             precipitation_probability > @precipitation_probability_threshold or
             till_dark < @till_dark_threshold,
      do: "NO"

  def to_machine(%Today{
        weather: %Condition{
          temperature: temperature,
          wind: wind,
          precipitation_probability: precipitation_probability
        },
        hours_till_dark: till_dark
      })
      when temperature >= @temperature_threshold and
             wind <= @wind_threshold and
             precipitation_probability <= @precipitation_probability_threshold and
             till_dark >= @till_dark_threshold,
      do: "YES"

  def to_machine(anything) do
    Logger.error("#{inspect(anything)} is not expected value for to_machine/1")
    "ERROR"
  end
end

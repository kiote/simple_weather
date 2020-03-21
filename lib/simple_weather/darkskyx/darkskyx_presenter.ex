defmodule SimpleWeather.DarkSkyxPresenter do
  def convert(%{"currently" => %{"apparentTemperature" => apparent_temperature}})
      when apparent_temperature <= 5,
      do: "6"

  def convert(%{"currently" => %{"apparentTemperature" => apparent_temperature}})
      when apparent_temperature > 5,
      do: "0"
end

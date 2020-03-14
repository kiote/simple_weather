defmodule SimpleWeather.DarkSkyxPresenter do
  def convert(%{"currently" => %{"apparentTemperature" => apparent_temperature}})
      when apparent_temperature <= 5 do
    "600000"
  end
end

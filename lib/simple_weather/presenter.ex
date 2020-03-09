defmodule SimpleWeather.Presenter do
  def result do
    today = SimpleWeather.WeatherReceiver.today
    IO.inspect(today)
    "600000"
  end
end

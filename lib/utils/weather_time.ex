defmodule SimpleWeather.Utils.WeatherTime do
  @behaviour SimpleWeather.Utils.WeatherTimeBehaviour

  @impl true
  def now do
    Timex.now() |> Timex.to_unix()
  end

  @impl true
  def to_hours(seconds) do
    seconds / 60 / 60
  end
end

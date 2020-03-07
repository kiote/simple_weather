defmodule SimpleWeather.DarkSkyxAdapter do
  @behaviour SimpleWeather.AdapterBehaviour

  @impl SimpleWeather.AdapterBehaviour
  def today() do
    Darkskyx.forecast(59.4716181, 24.5981613, %Darkskyx{exclude: "daily,minutely", units: "auto"})
  end
end

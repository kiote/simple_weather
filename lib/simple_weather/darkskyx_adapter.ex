defmodule SimpleWeather.DarkSkyxAdapter do
  @behaviour SimpleWeather.AdapterBehaviour

  @tallinn {59.4716181, 24.5981613}
  @forecast_defaults %Darkskyx{exclude: "daily,minutely", units: "auto"}

  @impl SimpleWeather.AdapterBehaviour
  def today() do
    {lat, long} = @tallinn
    Darkskyx.forecast(lat, long, @forecast_defaults)
  end
end

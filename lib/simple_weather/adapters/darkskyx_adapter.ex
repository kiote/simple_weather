defmodule SimpleWeather.DarkSkyxAdapter do
  @behaviour SimpleWeather.AdapterBehaviour

  @tallinn {59.4716181, 24.5981613}
  @forecast_defaults %Darkskyx{exclude: "daily,minutely", units: "auto"}

  @impl SimpleWeather.AdapterBehaviour
  def params_for_today() do
    {lat, long} = @tallinn
    %{lat: lat, long: long, defaults: @forecast_defaults}
  end

  @impl SimpleWeather.AdapterBehaviour
  def today() do
    %{lat: lat, long: long, defaults: defaults} = params_for_today()
    Darkskyx.forecast(lat, long, defaults)
  end
end

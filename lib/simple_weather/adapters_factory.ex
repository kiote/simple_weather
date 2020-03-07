defmodule SimpleWeather.AdaptersFactory.UnknownOrEmptyAdapter do
  @behaviour SimpleWeather.AdapterBehaviour

  def today() do
    raise "You must specify adapter in config"
  end
end

defmodule SimpleWeather.AdaptersFactory do
  alias SimpleWeather.AdaptersFactory.UnknownOrEmptyAdapter

  def darkskyx() do
    Application.get_env(:simple_weather, :darkskyx_adapter, UnknownOrEmptyAdapter)
  end
end

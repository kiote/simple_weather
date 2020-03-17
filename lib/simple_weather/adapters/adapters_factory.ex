defmodule SimpleWeather.AdaptersFactory.UnknownOrEmptyAdapter do
  @behaviour SimpleWeather.AdapterBehaviour

  @impl true
  def today() do
    raise "You must specify adapter in config"
  end

  @impl true
  def params_for_today() do
    raise "You must specify adapter in config"
  end

  @impl true
  def params_for_time_machine(_) do
    raise "You must specify adapter in config"
  end

  @impl true
  def time_machine(_) do
    raise "You must specify adapter in config"
  end

  @impl true
  def get_cache_key(_) do
    raise "You must specify adapter in config"
  end
end

defmodule SimpleWeather.AdaptersFactory do
  alias SimpleWeather.AdaptersFactory.UnknownOrEmptyAdapter

  def darkskyx() do
    Application.get_env(:simple_weather, :darkskyx_adapter, UnknownOrEmptyAdapter)
  end
end

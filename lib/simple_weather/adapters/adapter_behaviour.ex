defmodule SimpleWeather.AdapterBehaviour do
  @callback today() :: map()
  @callback params_for_today() :: map()
end

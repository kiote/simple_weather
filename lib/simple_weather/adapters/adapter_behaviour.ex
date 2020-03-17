defmodule SimpleWeather.AdapterBehaviour do
  @callback today() :: map()
  @callback params_for_today() :: map()
  @callback params_for_time_machine(atom() | nil) :: map()
  @callback time_machine(atom() | nil) :: map()
  @callback get_cache_key(map()) :: String.t()
end

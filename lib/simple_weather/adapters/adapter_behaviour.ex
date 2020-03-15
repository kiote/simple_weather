defmodule SimpleWeather.AdapterBehaviour do
  @callback today() :: map()
  @callback params_for_today() :: map()
  @callback time_machine(atom() | nil) :: map()
end

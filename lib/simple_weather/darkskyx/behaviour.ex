defmodule SimpleWeather.DarkskyxBehaviour do
  @callback forecast(any(), any(), any()) :: any()
  @callback time_machine(any(), any(), any(), any()) :: any()
end

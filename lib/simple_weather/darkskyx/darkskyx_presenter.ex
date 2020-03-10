defmodule SimpleWeather.DarkSkyxPresenter do
  def convert(%{"currently" => currently} = _forecast) do
    IO.inspect(currently)
    "600000"
  end
end

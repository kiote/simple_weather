defmodule SimpleWeatherWeb.PageController do
  use SimpleWeatherWeb, :controller

  def index(conn, _params) do
    impl = SimpleWeather.DarkSkyxAdapter
    text(conn, inspect(SimpleWeather.Abstraction.today(impl)))
  end

  def human(conn, _params) do
    text(conn, "not impelmented")
  end
end

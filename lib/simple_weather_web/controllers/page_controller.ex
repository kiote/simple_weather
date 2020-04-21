defmodule SimpleWeatherWeb.PageController do
  use SimpleWeatherWeb, :controller

  alias SimpleWeather.Presenter

  def index(conn, _params) do
    impl = SimpleWeather.DarkSkyxAdapter
    abstraction = SimpleWeather.Abstraction
    result = abstraction.today(impl)
    text(conn, Presenter.to_machine(result))
  end

  def human(conn, _params) do
    impl = SimpleWeather.DarkSkyxAdapter
    abstraction = SimpleWeather.Abstraction
    result = abstraction.today(impl)

    text(conn, "#{inspect(result)}")
  end
end

defmodule SimpleWeatherWeb.PageController do
  use SimpleWeatherWeb, :controller

  def index(conn, _params) do
    text(conn, SimpleWeather.Presenter.result())
  end

  def human(conn, _params) do
    text(conn, SimpleWeather.Presenter.human_readable_result())
  end
end

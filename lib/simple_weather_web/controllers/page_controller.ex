defmodule SimpleWeatherWeb.PageController do
  use SimpleWeatherWeb, :controller
  def index(conn, _params) do
    text(conn, "HI")
  end
end

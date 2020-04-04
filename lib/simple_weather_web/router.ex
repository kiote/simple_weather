defmodule SimpleWeatherWeb.Router do
  use SimpleWeatherWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SimpleWeatherWeb do
    pipe_through :api
    get "/", PageController, :index
  end

  get "/", SimpleWeatherWeb.PageController, :human
end

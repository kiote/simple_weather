defmodule SimpleWeather.DarkSkyxAdapterTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  alias SimpleWeather.AdaptersFactory

  test "invokes" do
    SimpleWeather.DarkSkyxAdapterMock
    |> expect(:today, fn -> %{} end)

    AdaptersFactory.darkskyx().today() |> IO.inspect()
  end
end

defmodule SimpleWeather.DarkSkyxAdapterTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  alias SimpleWeather.AdaptersFactory

  describe "today/0" do
    test "invokes" do
      SimpleWeather.DarkSkyxAdapterMock
      |> expect(:today, fn -> %{} end)

      assert AdaptersFactory.darkskyx().today()
    end

    test "caches the result" do
      SimpleWeather.DarkSkyxAdapterMock
      |> expect(:today, fn -> %{} end)

      AdaptersFactory.darkskyx().today()
      AdaptersFactory.darkskyx().today()
    end
  end
end

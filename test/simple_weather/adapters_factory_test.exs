defmodule SimpleWeather.AdaptersFactoryTest do
  use ExUnit.Case, async: true

  import Mox

  setup do
    verify_on_exit!()
    SimpleWeather.Utils.EtsCache.clear()
    :ok
  end

  alias SimpleWeather.AdaptersFactory

  describe "today/0" do
    test "invokes" do
      SimpleWeather.DarkSkyxAdapterMock
      |> expect(:today, fn -> %{} end)

      assert AdaptersFactory.darkskyx().today() == %{}
    end
  end

  describe "time_machine/1" do
    test "invokes" do
      SimpleWeather.DarkSkyxAdapterMock
      |> expect(:time_machine, fn _ -> %{} end)

      assert AdaptersFactory.darkskyx().time_machine(:yesterday) == %{}
    end
  end
end

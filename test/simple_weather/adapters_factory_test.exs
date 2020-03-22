defmodule SimpleWeather.AdaptersFactoryTest do
  use ExUnit.Case, async: true

  import Mox

  setup do
    verify_on_exit!()
    SimpleWeather.Utils.EtsCache.clear()
    :ok
  end

  alias SimpleWeather.AdaptersFactory
  alias SimpleWeather.AdaptersFactory.UnknownOrEmptyAdapter

  describe "today/0" do
    test "invokes" do
      SimpleWeather.DarkskyxAdapterMock
      |> expect(:today, fn -> %{} end)

      assert AdaptersFactory.darkskyx().today() == %{}
    end
  end

  describe "time_machine/1" do
    test "invokes" do
      SimpleWeather.DarkskyxAdapterMock
      |> expect(:time_machine, fn _ -> %{} end)

      assert AdaptersFactory.darkskyx().time_machine(:yesterday) == %{}
    end
  end

  describe "UnknownOrEmptyAdapter" do
    test "today" do
      assert_raise RuntimeError,
                   "You must specify adapter in config",
                   &UnknownOrEmptyAdapter.today/0
    end

    test "params_for_today" do
      assert_raise RuntimeError,
                   "You must specify adapter in config",
                   &UnknownOrEmptyAdapter.params_for_today/0
    end

    test "params_for_time_machine" do
      assert_raise RuntimeError, "You must specify adapter in config", fn ->
        UnknownOrEmptyAdapter.params_for_time_machine(1)
      end
    end

    test "time_machine" do
      assert_raise RuntimeError, "You must specify adapter in config", fn ->
        UnknownOrEmptyAdapter.time_machine(1)
      end
    end

    test "get_cache_key" do
      assert_raise RuntimeError, "You must specify adapter in config", fn ->
        UnknownOrEmptyAdapter.get_cache_key(1)
      end
    end
  end
end

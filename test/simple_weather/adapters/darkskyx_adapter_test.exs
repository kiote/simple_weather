defmodule SimpleWeather.DarkSkyxAdapterTest do
  use ExUnit.Case, async: true

  import Mox

  alias SimpleWeather.DarkSkyxAdapter
  alias SimpleWeather.Darkskyx.ParamsForTimeMachine
  alias SimpleWeather.Darkskyx.ParamsForToday

  setup do 
    :verify_on_exit!
    SimpleWeather.Utils.EtsCache.clear()
    :ok
  end

  test "params_for_today" do
    assert %SimpleWeather.Darkskyx.ParamsForToday{} = DarkSkyxAdapter.params_for_today()
  end

  test "params_for_time_machine" do
    assert %SimpleWeather.Darkskyx.ParamsForTimeMachine{} =
             DarkSkyxAdapter.params_for_time_machine()
  end

  test "today" do
    SimpleWeather.DarkskyxMock
    |> expect(:forecast, fn _, _, _ -> {:ok, "something", "nothing"} end)

    assert "something" = DarkSkyxAdapter.today()
  end

  test "time_machine" do
    SimpleWeather.DarkskyxMock
    |> expect(:time_machine, fn _, _, _, _ -> {:ok, "something", "something"} end)

    assert {:ok, _forecast, _headers} = DarkSkyxAdapter.time_machine()
  end

  test "get_cache_key with ParamsForToday" do
    assert "12" == DarkSkyxAdapter.get_cache_key(%ParamsForToday{lat: "1", long: "2"})
  end

  test "get_cache_key with ParamsForTimeMachine" do
    assert "123" ==
             DarkSkyxAdapter.get_cache_key(%ParamsForTimeMachine{
               lat: "1",
               long: "2",
               timestamp: "3"
             })
  end
end

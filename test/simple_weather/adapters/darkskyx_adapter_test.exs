defmodule SimpleWeather.DarkSkyxAdapterTest do
  use ExUnit.Case, async: true

  import Mox

  alias SimpleWeather.DarkSkyxAdapter

  test "params_for_today" do
    assert %SimpleWeather.Darkskyx.ParamsForToday{} = DarkSkyxAdapter.params_for_today()
  end

  test "params_for_time_machine" do
    assert %SimpleWeather.Darkskyx.ParamsForTimeMachine{} =
             DarkSkyxAdapter.params_for_time_machine()
  end

  test "today" do
    SimpleWeather.DarkskyxMock
    |> expect(:forecast, fn _, _, _ -> {:ok, "something", "something"} end)

    assert {:ok, _forecast, _headers} = DarkSkyxAdapter.today()
  end

  test "time_machine" do
    SimpleWeather.DarkskyxMock
    |> expect(:time_machine, fn _, _, _, _ -> {:ok, "something", "something"} end)

    assert {:ok, _forecast, _headers} = DarkSkyxAdapter.time_machine()
  end
end

defmodule SimpleWeather.PresenterTest do
  # there is some rase condition in cache
  # that's why this test is not async
  use ExUnit.Case, async: false

  import Mox

  setup do
    verify_on_exit!()
    SimpleWeather.Utils.EtsCache.clear()
    :ok
  end

  alias SimpleWeather.Presenter

  describe "result/0" do
    test "returns expected result" do
      weather_service_result =
        {:ok, %{"currently" => %{"apparentTemperature" => 10}}, "doesnt matter"}

      SimpleWeather.DarkskyxAdapterMock
      |> expect(:params_for_today, fn -> %{} end)
      |> expect(:get_cache_key, 4, fn _ -> "" end)
      |> expect(:params_for_time_machine, 3, fn _ -> Timex.now() |> Timex.to_unix() end)
      |> expect(:today, fn -> weather_service_result end)

      assert Presenter.result() == "0000"
    end
  end
end

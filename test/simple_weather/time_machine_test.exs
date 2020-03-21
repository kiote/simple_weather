defmodule SimpleWeather.TimeMachineTest do
  use ExUnit.Case, async: true

  alias SimpleWeather.TimeMachine

  describe "get_time_stamp/1" do
    test "yesterday" do
      assert TimeMachine.get_time_stamp(:yesterday) < Timex.now() |> Timex.to_unix()
    end

    test "the_day_before_yesterday" do
      assert TimeMachine.get_time_stamp(:the_day_before_yesterday) <
               TimeMachine.get_time_stamp(:yesterday)
    end

    test "two_days_before_yesterday" do
      assert TimeMachine.get_time_stamp(:two_days_before_yesterday) <
               TimeMachine.get_time_stamp(:the_day_before_yesterday)
    end
  end
end

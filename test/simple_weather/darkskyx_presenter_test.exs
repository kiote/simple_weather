defmodule Darkskyx.PresenterTest do
  use ExUnit.Case, async: true

  describe "convert/1" do
    test "when it's less than +5 degrees" do
      val = %{
        "currently" => %{
          "apparentTemperature" => -6.49,
        }
      }

      assert SimpleWeather.DarkSkyxPresenter.convert(val) == "6"
    end

    test "when it's more than +5 degrees" do
      val = %{
        "currently" => %{
          "apparentTemperature" => 6.49,
        }
      }

      assert SimpleWeather.DarkSkyxPresenter.convert(val) == "0"
    end
  end
end

defmodule SimpleWeather.CacheTest do
  use ExUnit.Case, async: true

  alias SimpleWeather.Cache

  defmodule TestAdapter do
    def get_cache_key(_) do
      "dummy"
    end
  end

  describe "maybe_get_from/3" do
    test "first call returns function value" do
      func = fn -> "value" end

      assert "value" == Cache.maybe_get_from("params", TestAdapter, func)
    end
  end

  describe "maybe_get_from/4" do
    test "first call returns function value" do
      func = fn _ -> "value" end

      assert "value" == Cache.maybe_get_from("params", TestAdapter, func, {})
    end
  end
end

defmodule SimpleWeather.CacheTest do
  use ExUnit.Case, async: true

  alias SimpleWeather.Cache
  alias SimpleWeather.Utils.EtsCache

  defmodule TestAdapter do
    def get_cache_key(_) do
      "dummy"
    end
  end

  def clear_cache() do
    EtsCache.clear()
  end

  setup do
    clear_cache()
    :ok
  end

  describe "maybe_get_from/3" do
    test "first call returns function value" do
      func = fn -> "value" end
      assert "value" == Cache.maybe_get_from("params", TestAdapter, func)
    end

    test "two calls return cached value" do
      func = fn -> "value" end
      assert "value" == Cache.maybe_get_from("params", TestAdapter, func)
      func = nil
      assert "value" == Cache.maybe_get_from("params", TestAdapter, func)
    end
  end

  describe "maybe_get_from/4" do
    test "first call returns function value" do
      func = fn _ -> "value" end
      assert "value" == Cache.maybe_get_from("params", TestAdapter, func, {})
    end

    test "two calls return cached value" do
      func = fn _ -> "value" end
      assert "value" == Cache.maybe_get_from("params", TestAdapter, func, {})
      func = nil
      assert "value" == Cache.maybe_get_from("params", TestAdapter, func, {})
    end
  end
end

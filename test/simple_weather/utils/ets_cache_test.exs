defmodule SimpleWeather.Utils.EtsCacheTest do
  use ExUnit.Case, async: true

  alias SimpleWeather.Utils.EtsCache

  describe "put/1" do
    test "adds element to the cache" do
      assert EtsCache.put({"key", "val", 1}) == "val"
    end

    test "adds value in a way that it can be extracted from a cache" do
      EtsCache.put({"key", "value", 1})
      assert "value" == EtsCache.get("key")
    end

    test "invalidates after given ttl" do
      EtsCache.put({"key", "value", 1})
      :timer.sleep(2)
      refute EtsCache.get("key")
    end
  end
end

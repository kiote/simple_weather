defmodule SimpleWeather.Utils.EtsCacheTest do
  use ExUnit.Case, async: true

  alias SimpleWeather.Utils.EtsCache

  describe "handle_call(:put)" do
    test "adds element to the cache" do
      assert EtsCache.handle_call(:put, nil, {"key", "value", 1}) == {:reply, "value"}
    end

    test "adds value in a way that it can be extracted from a cache" do
      EtsCache.handle_call(:put, nil, {"key", "value", 1})
      assert {:reply, %{value: "value"}} = EtsCache.handle_call(:get, nil, "key")
    end
  end
end

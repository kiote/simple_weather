defmodule SimpleWeather.Utils.CommonCache do
  use GenServer

  @table_name :common_cache

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  @impl true
  def init(_) do
    case :ets.whereis(@table_name) do
      :undefined -> :ets.new(@table_name, [:set, :public, :named_table, read_concurrency: true])
      _ -> :ok
    end

    {:ok, []}
  end

  def get(key) do
    case :ets.lookup(@table_name, key) do
      [{^key, %{value: _, ttl: _} = entry}] -> entry
      [] -> nil
      x -> x
    end
  end

  def put(key, value, ttl) do
    :ets.insert(@table_name, {key, %{value: value, ttl: calculate_ttl(ttl)}})
    value
  end

  def clear, do: :ets.delete_all_objects(@table_name)

  def calculate_ttl(ttl) when is_integer(ttl), do: DateTime.add(DateTime.utc_now(), ttl, :second)
end

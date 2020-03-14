defmodule SimpleWeather.Utils.EtsCache do
  use GenServer

  # Client

  @table_name :common_cache

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def put({_key, _value, _ttl} = params) do
    GenServer.call(__MODULE__, {:put, params})
  end

  def clear, do: :ets.delete_all_objects(@table_name)

  # Server 

  @impl true
  def init(_) do
    case :ets.whereis(@table_name) do
      :undefined ->
        :ets.new(@table_name, [:set, :public, :named_table, read_concurrency: true])

      _ ->
        :ok
    end

    {:ok, []}
  end

  @impl true
  def handle_call({:get, key}, _from, _) do
    {:reply,
     case :ets.lookup(@table_name, key) do
       [{^key, %{value: value}}] -> value
       [] -> nil
     end, :no_state}
  end

  @impl true
  def handle_call({:put, {key, value, ttl}}, _from, _) do
    :ets.insert(@table_name, {key, %{value: value}})
    Process.send_after(self(), {:invalidate, key}, ttl)
    {:reply, value, :no_state}
  end

  @impl true
  def handle_info({:invalidate, key}, _) do
    :ets.delete(@table_name, key)
    {:noreply, :no_state}
  end
end

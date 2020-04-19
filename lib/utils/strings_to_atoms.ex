defmodule Utils.StringsToAtoms do
  require Logger

  def convert(string_key_map) when is_map(string_key_map) do
    for {key, val} <- string_key_map, into: %{}, do: {String.to_atom(key), convert(val)}
  end

  def convert(string_key_list) when is_list(string_key_list) do
    for val <- string_key_list, into: [], do: convert(val)
  end

  def convert(value), do: value
end

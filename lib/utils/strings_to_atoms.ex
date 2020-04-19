defmodule Utils.StringsToAtoms do
  require Logger

  def convert(string_key_map) when is_map(string_key_map) do
    for {key, val} <- string_key_map, into: %{}, do: do_convert(key, val)
  end

  def convert(string_key_list) when is_list(string_key_list) do
    for val <- string_key_list, into: [], do: convert(val)
  end

  def convert(value), do: value

  defp do_convert(key, val) when is_binary(key) do
    {String.to_atom(key), convert(val)}
  end

  defp do_convert(key, val) do
    {key, convert(val)}
  end
end

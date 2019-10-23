defmodule Revolutex.Util do
  @moduledoc false

  def atomize_keys(map) when is_map(map) do
    Enum.into(map, %{}, fn {k, v} -> {atomize_key(k), atomize_keys(v)} end)
  end

  def atomize_keys([head | rest]), do: [atomize_keys(head) | atomize_keys(rest)]
  def atomize_keys(not_a_map), do: not_a_map

  def atomize_key(k) when is_binary(k), do: String.to_atom(k)
  def atomize_key(k), do: k
end

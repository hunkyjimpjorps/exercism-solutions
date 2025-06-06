defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(x) when not is_integer(x) or x < 0 do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end
  def generate(1), do: [2]
  def generate(2), do: [2, 1]
  def generate(n) do
    Stream.unfold({2, 1}, fn {n0, n1} -> {n0, {n1, n0 + n1}} end) |> Enum.take(n)
  end
end

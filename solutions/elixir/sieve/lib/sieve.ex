defmodule Sieve do
  @moduledoc false
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit <= 1, do: []
  def primes_to(2), do: [2]

  def primes_to(limit) do
    do_next_filtering(Enum.to_list(3..limit//2), limit, [2])
  end

  def do_next_filtering([x | _xs] = list, limit, acc) when x * x > limit do
    Enum.reverse(acc) ++ list
  end

  def do_next_filtering([x | xs], limit, acc) do
    Enum.reject(xs, fn n -> n in Enum.to_list((2 * x)..limit//x) end)
    |> (&do_next_filtering(&1, limit, [x | acc])).()
  end
end

defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)

  def generate(max_factor, min_factor) when max_factor < min_factor do
    raise ArgumentError
  end

  def generate(max_factor, min_factor) do
    make_products(max_factor, min_factor)
    |> Enum.group_by(fn {n, _} -> n end, fn {_, ij} -> ij end)
    |> Enum.into(%{})
  end

  def make_products(max_factor, min_factor) do
    for i <- min_factor..max_factor,
        j <- i..max_factor,
        palindrome?(i * j) do
      {i * j, [i, j]}
    end
  end

  def palindrome?(n) do
    forwards = Integer.to_string(n)
    backwards = String.reverse(forwards)

    forwards == backwards
  end
end

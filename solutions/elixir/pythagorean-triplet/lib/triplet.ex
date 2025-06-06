defmodule Triplet do
  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(xs), do: Enum.sum(xs)

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(xs), do: Enum.product(xs)

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]), do: a ** 2 + b ** 2 == c ** 2

  @doc """
  Generates a list of pythagorean triplets whose values add up to a given sum.
  """
  @spec generate(non_neg_integer) :: [list(non_neg_integer)]
  def generate(sum) do
    for a <- 1..div(sum, 3),
        b <- (a + 1)..div(sum, 2),
        c_candidate = sum - b - a,
        pythagorean?([a, b, c_candidate]) do
      [a, b, c_candidate]
    end
  end
end

defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer

  def to(limit, factors) do
    factors_without_zero = Enum.reject(factors, &(&1 == 0))

    Enum.filter(0..(limit - 1), fn n -> Enum.any?(factors_without_zero, &(rem(n, &1) == 0)) end)
    |> Enum.sum()
  end
end

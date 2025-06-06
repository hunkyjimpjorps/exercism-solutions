defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """
  @cannot_change {:error, "cannot change"}

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    do_generate(Enum.sort(coins, :desc), target, [], @cannot_change)
  end

  defp do_generate(_coins, _target, current, {:ok, best})
       when length(current) >= length(best),
       do: {:ok, best}

  defp do_generate(_coins, 0, current, _), do: {:ok, current}
  defp do_generate([], _target, _current, best), do: best

  defp do_generate([coin | rest], target, current, best) when coin > target do
    do_generate(rest, target, current, best)
  end

  defp do_generate([coin | rest] = coins, target, current, best) do
    remaining = do_generate(coins, target - coin, [coin | current], best)
    do_generate(rest, target, current, remaining)
  end
end

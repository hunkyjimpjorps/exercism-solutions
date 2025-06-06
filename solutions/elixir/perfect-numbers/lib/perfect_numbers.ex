defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1, do: {:error, "Classification is only possible for natural numbers."}
  def classify(number) do
    case factors(number) do
      n when n == 2 * number -> {:ok, :perfect}
      n when n > 2 * number -> {:ok, :abundant}
      n when n < 2 * number -> {:ok, :deficient}      
    end
  end

  defp factors(number) do
    Enum.filter(Enum.to_list(1..floor(:math.sqrt(number))), fn f -> Integer.mod(number, f) == 0 end)
    |> Enum.flat_map(fn n -> if(div(number, n) == n, do: [n], else: [n, div(number, n)]) end)
    |> Enum.sum()
  end
end

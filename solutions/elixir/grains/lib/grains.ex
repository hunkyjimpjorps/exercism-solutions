defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(number) when number in 1..64 do
    {:ok, 2 ** (number - 1)}
  end

  def square(_), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    Enum.reduce(1..64, 0, fn n, sum ->
      with {:ok, grains} <- square(n) do
        grains + sum
      end
    end)
    |> then(&{:ok, &1})
  end
end